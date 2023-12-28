import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../models/pill_reminder/pill.dart';
import '../../utils/gridbackground.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  List<Pill> pillsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readPill();
  }

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      // defaults to false
      insetOnOverlap: true,
      children: <Widget>[
        /*const SliverPositioned.fill(
          child: GridBackground(),
        ),*/
        SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            sliver: SliverFillRemaining(
                child: ListView.separated(
                    itemCount: (pillsList != null) ? pillsList.length : 0,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      Pill pill = pillsList![index];
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Dismissible(
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Remove',
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              key: UniqueKey(),
                              child: PillCard(
                                index: index,
                                pill: pill,
                              ),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  /*Provider.of<DataModel>(context, listen: false)
                                      .removePill(pill);*/
                                });
                              }));
                    }))),
      ],
    );
  }

  Future<Map<String, dynamic>> readPill() async {
    Map<String, dynamic>? data = {};
    final dirPath = await getApplicationSupportDirectory();
    print('dirPath ::$dirPath');
    if (!File('$dirPath/data.json').existsSync()) {
      //File('$dirPath/data.json').createSync(recursive: true);
      print('getDirPath Exists ::');
    }
    final String rawData = File('${dirPath.path}/data.json').readAsStringSync();
    print('rawData Exists :: $rawData');
    print('RAWDATA :${rawData.isNotEmpty}');
    if (rawData.isNotEmpty) {
      try {
        Map<String, dynamic> raw = jsonDecode(rawData);
        for (String date in raw.keys) {
          List<dynamic> pills = raw[date];
          setState(() {
            pillsList = List<Pill>.generate(pills.length, (index) {
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
          });
        }
        print('pillsList ::: $pillsList');
      } catch (e) {
        print('CATCH :::' + e.toString());
      }
    }

    return data;
  }
}

class PillCard extends StatelessWidget {
  const PillCard(
      {Key? key, required this.pill, required this.index, this.onTap})
      : super(key: key);

  final Pill pill;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        onTap?.call();
      }),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xffCC197D))),
          child: Row(children: [
            Hero(
              tag: 'image$index',
              child: Image.asset(
                "assets/images/${pill.image}",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${pill.title}, ${pill.weight}mg',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Text(
                  '${pill.dosage} pill',
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.33),
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Iconsax.clock,
                      size: 18,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.33),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      pill.time.format(context),
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.33)),
                    )
                  ],
                )
              ],
            )
          ])),
    );
  }
}
