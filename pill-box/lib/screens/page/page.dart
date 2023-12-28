import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/models/page/page_data.dart';
import 'package:flybuy/screens/post/blocks/blocks.dart';
import 'package:flybuy/service/service.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/webview_flutter.dart';
import 'package:flybuy/widgets/flybuy_webview.dart';
import 'package:provider/provider.dart';

class PageScreen extends StatefulWidget {
  static const routeName = '/page';

  final Map? args;

  const PageScreen({Key? key, this.args}) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen>
    with LoadingMixin, SnackMixin, AppBarMixin {
  PageData? _pageData;
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Instance post receive
    if (widget.args!['post'] != null &&
        widget.args!['post'].runtimeType == PageData) {
      _pageData = widget.args!['post'];
      setState(() {
        _loading = false;
      });
    } else {
      getPost(ConvertData.stringToInt(widget.args!['id']));
    }
  }

  Future<void> getPost(int id) async {
    try {
      _pageData =
          await Provider.of<RequestHelper>(context).getPageDetail(idPage: id);
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (context.mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pageData == null) {
      return Scaffold(
        appBar: baseStyleAppBar(context, title: widget.args!['name'] ?? ''),
        body: Container(),
      );
    }
    return Scaffold(
      appBar: baseStyleAppBar(context, title: widget.args!['name'] ?? ''),
      body: widget.args != null && widget.args!['url'] == null
          ? CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: paddingHorizontal.copyWith(
                      top: itemPaddingExtraLarge, bottom: itemPaddingLarge),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index == _pageData!.blocks!.length - 1) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PostBlock(block: _pageData!.blocks![index]),
                            ],
                          );
                        }
                        return PostBlock(block: _pageData!.blocks![index]);
                      },
                      childCount: _pageData!.blocks!.length,
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                FlybuyWebView(
                  uri: Uri.parse(widget.args!['url']),
                  onNavigationRequest: (NavigationRequest request) {
                    avoidPrint('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  },
                  loading: buildLoading(context, isLoading: true),
                ),
                if (_loading) buildLoading(context, isLoading: _loading),
              ],
            ),
    );
  }
}
