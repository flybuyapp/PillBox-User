import 'package:flutter/material.dart';
import 'package:flybuy/mixins/loading_mixin.dart';
import 'package:flybuy/models/post/post.dart';
import 'package:flybuy/utils/debug.dart';
import 'package:flybuy/webview_flutter.dart';
import 'package:flybuy/widgets/flybuy_webview.dart';

class PostEvent extends StatefulWidget {
  final Post? post;

  const PostEvent({Key? key, this.post}) : super(key: key);

  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> with LoadingMixin {
  @override
  Widget build(BuildContext context) {
    Map<String, String> qs = {
      'app-builder-checkout-body-class': 'app-builder-event-screens'
    };

    String checkoutUrl =
        "${widget.post!.link!}?${Uri(queryParameters: qs).query}";

    avoidPrint(checkoutUrl);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.post!.postTitle!),
      ),
      body: FlybuyWebView(
        uri: Uri.parse(checkoutUrl),
        onNavigationRequest: (NavigationRequest request) {
          avoidPrint('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        loading: buildLoading(context, isLoading: true),
      ),
    );
  }
}
