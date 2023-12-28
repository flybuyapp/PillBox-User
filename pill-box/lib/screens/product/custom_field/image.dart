import 'package:flutter/material.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/flybuy_cache_image.dart';

class FieldImage extends StatelessWidget with Utility {
  final dynamic value;
  final String? align;
  final String format;

  const FieldImage({Key? key, this.value, this.align, this.format = 'array'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (format == 'id' &&
        (value is int || (value is String && !value.isEmpty))) {
      TextAlign textAlign = ConvertData.toTextAlignDirection(align);
      return Text('$value', textAlign: textAlign);
    }

    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double widthImage = constraints.maxWidth != double.infinity
          ? constraints.maxWidth
          : width;
      if (format == 'array' && value is Map) {
        return buildImageArray(value, widthImage);
      }

      if (format == 'url' && value is String) {
        return buildImageUrl(value, widthImage);
      }

      return Container();
    });
  }

  Widget buildImageArray(Map data, double width) {
    String url = get(data, ['url'], '');
    double widthData =
        ConvertData.stringToDouble(get(data, ['width'], width), width);
    double heightData =
        ConvertData.stringToDouble(get(data, ['height'], width), width);

    double widthImage = width;
    double heightImage = (widthImage * heightData) / widthData;

    return FlybuyCacheImage(url, width: widthImage, height: heightImage);
  }

  Widget buildImageUrl(String data, double width) {
    return FlybuyCacheImage(data, width: width, height: width);
  }
}
