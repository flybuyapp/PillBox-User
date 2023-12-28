import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/store/store.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/debug.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flybuy_download_button.dart';

class FlybuyDownloadItem extends StatefulWidget {
  final Download download;
  final DownloadCallbackType callbackDownload;

  const FlybuyDownloadItem({
    Key? key,
    required this.download,
    required this.callbackDownload,
  }) : super(key: key);

  @override
  State<FlybuyDownloadItem> createState() => _FlybuyDownloadItemState();
}

class _FlybuyDownloadItemState extends State<FlybuyDownloadItem>
    with DownloadMixin {
  late final DownloadController _downloadController;

  @override
  void initState() {
    _downloadController = HandleDownloadController(
      onOpenDownload: () {
        _openDownload();
      },
      onCallbackDownload: widget.callbackDownload,
    );
    super.initState();
  }

  void _openDownload() {
    avoidPrint('Open download');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AuthStore authStore = Provider.of<AuthStore>(context);
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
      child: Padding(
        padding: paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildProductName(context,
                          download: widget.download, theme: theme),
                      const SizedBox(height: 8),
                      buildRemaining(context,
                          download: widget.download, theme: theme),
                      buildFileName(context,
                          download: widget.download, theme: theme),
                      buildExpire(context,
                          download: widget.download, theme: theme),
                    ],
                  ),
                ),
                const SizedBox(width: itemPaddingMedium),
                buildButtonDownload(
                  download: widget.download,
                  button: AnimatedBuilder(
                    animation: _downloadController,
                    builder: (_, child) {
                      return FlybuyDownloadButton(
                        status: _downloadController.downloadStatus,
                        onDownload: () => _downloadController.startDownload(
                            widget.download, authStore.token ?? ''),
                        onCancel: _downloadController.stopDownload,
                        onOpen: _downloadController.openDownload,
                      );
                    },
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: _downloadController,
              builder: (context, child) {
                if (_downloadController.downloadStatus ==
                    DownloadStatus.downloading) {
                  return Padding(
                    padding: const EdgeInsets.only(top: itemPaddingMedium),
                    child: FlybuyDownloadButtonLoading(
                      downloadProgress: _downloadController.progress,
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
