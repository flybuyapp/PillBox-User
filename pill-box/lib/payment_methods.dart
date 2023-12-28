import 'package:flybuy/screens/checkout/gateway/gateway.dart';
import 'package:payment_base/payment_base.dart';
import 'package:paypal_gateway/paypal_gateway_web.dart';
import 'package:stripe_gateway/stripe_gateway_web.dart';
// import 'package:tabby_gateway/tabby_gateway.dart';

final Map<String, PaymentBase> methods = {
  ChequeGateway.key: ChequeGateway(),
  CodGateway.key: CodGateway(),
  BacsGateway.key: BacsGateway(),
  StripeGatewayWeb.key: StripeGatewayWeb(),
  PayPalGatewayWeb.key: PayPalGatewayWeb(),
  // TabbyGateway.key: TabbyGateway(),
  // PayTabsGateway.key: PayTabsGateway(
  //     serverKeyForMobile: "YOUR_SERVER_MOBILE_KEY",
  //     clientKeyForMobile: "YOUR_CLIENT_MOBILE_KEY",
  //     merchantCountryCode: "US"),
};
