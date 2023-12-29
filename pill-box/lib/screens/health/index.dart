import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flybuy/screens/health/formpage.dart';
import 'package:flybuy/screens/health/reminderlist.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/buttons.dart';
import 'calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    requestPermission(context);
  }

  Future<bool> requestPermission(BuildContext context) async {
    PermissionStatus result;
    PermissionStatus resultNearby;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.storage.request();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButtonWidget(
        color: Colors.black,
        onPressed: () async {
          await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => FormPage()));
        },
        icon: Icons.add,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: false,
              delegate: TopBar(),
            ),
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: CalendarDelegate(),
            ),
            const ReminderList()
          ],
        ),
      ),
    );
  }
}

class TopBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xffCC197D),
      width: 150,
      child: Stack(fit: StackFit.expand, children: [
        Positioned(
            top: 10,
            left: 15,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:
                    const Icon(Icons.arrow_back_ios_new, color: Colors.white))),
        Positioned(
            left: 15,
            bottom: 40,
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 32,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Add ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Medicine',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            )),
      ]),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
