import 'package:flybuy/models/setting/setting.dart';
import 'package:flybuy/screens/home/widgets/builder_widgets.dart';
import 'package:flybuy/store/setting/setting_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

/// Home tab
/// Handle build widget from config
class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  late SettingStore _settingStore;

  @override
  void didChangeDependencies() {
    _settingStore = Provider.of<SettingStore>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("tabhomeinit:::");
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_settingStore.data == null || _settingStore.data!.screens == null)
        return Container();
      // Home config
      final Data? data = _settingStore.data!.screens!['home'];
      return BuilderWidgets(
        data: data,
      );
    });
  }
}
