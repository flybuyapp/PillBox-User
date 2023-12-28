import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import '../../models/pill_reminder/pill.dart';
import 'notification.dart';

var datetimeformatter = DateFormat('yyyy-MMM-dd');

Future<String> getDirPath() async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<Map<String, dynamic>> readPill() async {
  Map<String, dynamic>? data = {};
  final dirPath = await getDirPath();
  if (!File('$dirPath/data.json').existsSync()) {
    File('$dirPath/data.json').createSync(recursive: true);
  }
  final String rawData = File('$dirPath/data.json').readAsStringSync();
  if (rawData.isNotEmpty) {
    try {
      Map<String, dynamic> raw = jsonDecode(rawData);
      for (String date in raw.keys) {
        List<dynamic> pills = raw[date];
        data[date] = List<Pill>.generate(pills.length, (index) {
          return Pill(
              weight: pills[index]['weight'],
              span: int.parse(pills[index]['span']),
              time: TimeOfDay(hour: pills[index]['time'], minute: 0),
              description: pills[index]['description'],
              food: pills[index]['food'],
              image: pills[index]['image'],
              title: pills[index]['title'],
              dosage: pills[index]['dosage']);
        });
      }
    } catch (e) {
      print('CATCH :::' + e.toString());
    }
  }

  return data;
}

Future<Map<String, List<Pill>>?> writeData(Pill data) async {
  print('writeData :::${data.span}');
  final dirPath = await getApplicationSupportDirectory();
  final File filepath = File('${dirPath.path}/data.json');
  Map<String, List<Pill>>? pillList =
      (await readPill()).cast<String, List<Pill>>();
  Map file = {};
  final dates = List<DateTime>.generate(
      data.span!,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));
  print('dates ::: ${dates.length}');
  for (DateTime date in dates) {
    String key = datetimeformatter.format(date);
    print('keye ::: ${key}');
    if (pillList.containsKey(key)) {
      pillList[key] = (pillList[key]! + [data]);
    } else {
      pillList[key] = [data];
    }
    print('data.time ::: ${data.time}');
    await createNotification(data.time, date.day);
  }
  inspect(pillList);

  for (String date in pillList.keys) {
    List<Map> temp = [];
    for (var e in pillList[date]!) {
      temp.add(e.toJson());
    }
    file[date] = temp;
  }
  /*if (!File('$dirPath/data.json').existsSync()) {
    print('exists');
    await filepath.writeAsString(',' + jsonEncode(file), mode: FileMode.append);
  } else {*/
  print('exists_else');
  await filepath.writeAsString(jsonEncode(file));
  //}

  return pillList;
}
