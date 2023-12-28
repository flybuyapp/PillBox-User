import 'package:flutter/material.dart';
import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/screens/search/search_feature.dart';
import 'package:flybuy/store/store.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:ui/ui.dart';

abstract class SearchWidget extends StatefulWidget {
  final WidgetConfig? widgetConfigData;
  final bool? typePost;
  final Widget Function(Color?)? iconScan;

  const SearchWidget({
    Key? key,
    this.widgetConfigData,
    this.typePost,
    this.iconScan,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with Utility, ContainerMixin {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore.themeModeKey;
    String languageKey = settingStore.languageKey;

    // Styles
    Map<String, dynamic> styles = widget.widgetConfigData?.styles ?? {};
    Map<String, dynamic>? margin = get(styles, ['margin'], {});
    Map<String, dynamic>? padding = get(styles, ['padding'], {});
    Color background = ConvertData.fromRGBA(
        get(styles, ['background', themeModeKey], {}), Colors.transparent);
    Color backgroundInput = ConvertData.fromRGBA(
        get(styles, ['backgroundColorInput', themeModeKey], {}),
        theme.cardColor);
    Color borderColor = ConvertData.fromRGBA(
        get(styles, ['borderColorInput', themeModeKey], {}),
        theme.dividerColor);
    Color iconColor = ConvertData.fromRGBA(
        get(styles, ['iconColorInput', themeModeKey], {}), Colors.black);

    // General config
    Map<String, dynamic> fields = widget.widgetConfigData?.fields ?? {};
    bool enableIcon = get(fields, ['enableIcon'], true);
    bool enableIconLeft = get(fields, ['enableIconLeft'], true);
    bool enableScan = get(fields, ['enableScan'], false);
    bool enableScanLeft = get(fields, ['enableScanLeft'], true);
    dynamic placeholder = get(fields, ['placeholder'], {});

    Map? iconData =
        get(fields, ['icon'], {'type': 'feather', 'name': 'search'});

    String textPlaceholder =
        ConvertData.textFromConfigs(placeholder, languageKey);
    TextStyle textStyle = ConvertData.toTextStyle(placeholder, themeModeKey);

    Widget iconWidget =
        FlybuyIconBuilder(data: iconData, size: 16, color: iconColor);

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      padding: ConvertData.space(padding, 'padding'),
      decoration: decorationColorImage(color: background),
      child: SearchFeature(
        enableSearchPost: widget.typePost,
        //NGD
        //borderRadius: borderRadiusExtraLarge,
        child: Search(
          scannerIcon: enableScan ? widget.iconScan?.call(iconColor) : null,
          icon: enableIcon ? iconWidget : null,
          label: Text(
            textPlaceholder,
            style: theme.textTheme.bodyLarge?.merge(textStyle),
          ),
          shape: RoundedRectangleBorder(
            //NGD
            //borderRadius: borderRadiusExtraLarge,
            side: BorderSide(width: 1, color: borderColor),
          ),
          color: backgroundInput,
          enableIconLeft: enableIconLeft,
          enableScanLeft: enableScanLeft,
        ),
      ),
    );
  }
}
