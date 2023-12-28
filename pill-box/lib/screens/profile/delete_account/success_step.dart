import 'package:awesome_icons/awesome_icons.dart';
import 'package:flybuy/constants/styles.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui/notification/notification_screen.dart';

class SuccessStep extends StatelessWidget with AppBarMixin {
  final VoidCallback onComplete;

  const SuccessStep({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Scaffold(
      appBar: AppBar(
        leading: iconButtonLeading(onPressed: onComplete),
        title: Text(translate('delete_account_txt')),
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          padding: paddingLarge,
          child: NotificationScreen(
            iconData: FontAwesomeIcons.userTimes,
            title: Container(
              margin: paddingHorizontal,
              child: Text(
                translate('delete_account_success_title'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            content: Padding(
              padding: paddingHorizontal,
              child: Text(
                translate('delete_account_success_subtitle'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            styleBtn: ElevatedButton.styleFrom(padding: paddingHorizontalLarge),
            textButton: Text(translate('delete_account_success_button')),
            onPressed: onComplete,
          ),
        ),
      ),
    );
  }
}
