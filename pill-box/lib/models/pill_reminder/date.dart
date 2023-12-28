import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flybuy/models/pill_reminder/pill.dart';

import '../../service/pill reminder/network.dart';

class DataModel extends ChangeNotifier {
  Map<String, List<Pill>> _pills = {};
  DateTime _selectedDate = DateTime(2022, 09, 26);

  List<Pill>? get datePills => _pills[datetimeformatter.format(_selectedDate)];

  Future<Map<String, List<Pill>>?> loadData() async {
    Map<String, List<Pill>> data =
        (await readPill()).cast<String, List<Pill>>();
    notifyListeners();
    return data;
  }

  set selectedDate(DateTime value) {
    if (value != _selectedDate) {
      _selectedDate = value;
      notifyListeners();
    }
  }

  DateTime get selectedDate => _selectedDate;

  add(Pill pill) async {
    Map<String, List<Pill>>? data = await writeData(pill);
    _pills = (await loadData())!;
    log("add pillsss:::$_pills");
    inspect(_pills);
    notifyListeners();
  }

  void removePill(Pill pill) {
    _pills[datetimeformatter.format(_selectedDate)]?.remove(pill);
    notifyListeners();
  }
}
