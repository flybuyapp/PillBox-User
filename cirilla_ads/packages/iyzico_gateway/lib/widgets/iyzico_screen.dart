import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iyzico_gateway/utils/helper.dart';

class IyzicoScreen extends StatefulWidget {
  final Function(dynamic data) callback;
  final Future Function(List p1) checkout;
  final String iyzicoKey;
  final Widget Function(
    String url,
    BuildContext context, {
    String Function(String url)? customHandle,
  }) webViewGateway;
  const IyzicoScreen({
    Key? key,
    required this.callback,
    required this.checkout,
    required this.iyzicoKey,
    required this.webViewGateway,
  }) : super(key: key);

  @override
  State<IyzicoScreen> createState() => _IyzicoScreenState();
}

class _IyzicoScreenState extends State<IyzicoScreen> {
  bool _loading = false;
  String url = '';
  bool iyzicoCheckout = false;

  @override
  void initState() {
    iyzicoCheckout = widget.iyzicoKey == 'iyzico';
    onCheckout();
    super.initState();
  }

  void setLoading(bool isLoading) {
    setState(() {
      _loading = isLoading;
    });
  }

  onCheckout() async {
    try {
      setLoading(true);
      dynamic checkoutData = await widget.checkout([]);
      
      List paymentDetails = getData(checkoutData, ['payment_result', 'payment_details'], "");

      String value = getData(paymentDetails[0], ['value'], '');

      value = value.replaceFirst('document.getElementById("infoBox").style.display="block",', '');

      if (iyzicoCheckout) {
        url = Uri.dataFromString(html(value), mimeType: 'text/html').toString();
      } else {
        url = getData(checkoutData, ['payment_result', 'redirect_url'], "");
      }
      setLoading(false);
    } catch (e) {
      setLoading(false);
      widget.callback(e);
      if (mounted) Navigator.of(context).pop();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loading = _loading && url == '';
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.chevron_left_rounded, size: 30),
        ),
        title: const Text('Iyzico Checkout'),
        centerTitle: true,
        elevation: 0,
      ),
      body: loading
          ? Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            )
          : widget.webViewGateway(
              url,
              context,
              customHandle: iyzicoCheckout
                  ? (url) {
                      if (!url.contains('wc-api')) {
                        Navigator.of(context).pop({'order_received_url': url});
                        return "prevent";
                      }
                      return "";
                    }
                  : null,
            ),
    );
  }
}

String html(String value) {
  return """
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,user-scalable=no">
	<title>JS Bin</title>
	<script src="https://app.demo-app.shop/wp-includes/js/jquery/jquery.min.js?ver=3.7.0" id="jquery-core-js"></script>
	<script src="https://app.demo-app.shop/wp-includes/js/jquery/jquery-migrate.min.js?ver=3.4.1"
		id="jquery-migrate-js"></script>
</head>

<body>
	<div id="iyzipay-checkout-form" class="responsive"></div>

	<style>
		.loading {
			width: 40px;
			height: 40px;
			background-color: #1E64FF;
			margin: auto;
			-webkit-animation: sk-rotateplane 1.2s infinite ease-in-out;
			animation: sk-rotateplane 1.2s infinite ease-in-out
		}

		@-webkit-keyframes sk-rotateplane {
			0% {
				-webkit-transform: perspective(120px)
			}

			50% {
				-webkit-transform: perspective(120px) rotateY(180deg)
			}

			100% {
				-webkit-transform: perspective(120px) rotateY(180deg) rotateX(180deg)
			}
		}

		@keyframes sk-rotateplane {
			0% {
				transform: perspective(120px) rotateX(0) rotateY(0);
				-webkit-transform: perspective(120px) rotateX(0) rotateY(0)
			}

			50% {
				transform: perspective(120px) rotateX(-180.1deg) rotateY(0);
				-webkit-transform: perspective(120px) rotateX(-180.1deg) rotateY(0)
			}

			100% {
				transform: perspective(120px) rotateX(-180deg) rotateY(-179.9deg);
				-webkit-transform: perspective(120px) rotateX(-180deg) rotateY(-179.9deg)
			}
		}
	</style>
	<div id="loadingBar">
		<div class="loading">
		</div>
		<div class="brand">
			<p style="text-align:center;color:#1E64FF;">iyzico</p>
		</div>
	</div>
	$value
</body>

</html>
""";
}
