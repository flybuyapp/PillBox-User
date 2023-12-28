import 'package:flybuy/models/setting/setting.dart';
import 'package:flybuy/widgets/builder/product_search/search_widget.dart';
import 'package:flutter/material.dart';

class PostSearchWidget extends SearchWidget {
  final WidgetConfig widgetConfig;
  const PostSearchWidget({
    Key? key,
    required this.widgetConfig,
  }) : super(
          key: key,
          widgetConfigData: widgetConfig,
          typePost: true,
        );
}
