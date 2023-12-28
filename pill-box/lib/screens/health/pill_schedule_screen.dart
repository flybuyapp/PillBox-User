import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PillScheduleScreen extends StatefulWidget {
  const PillScheduleScreen({super.key});

  @override
  State<PillScheduleScreen> createState() => _PillScheduleScreenState();
}

class _PillScheduleScreenState extends State<PillScheduleScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new),
        actions: [Icon(Icons.close)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Schedule",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Image.asset(
                  "assets/tablet.png",
                  height: 12.h,
                  width: 15.w,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Omega 3",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1 tablet after meals",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff8C8E97)),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          "7 days left",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff8C8E97)),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dose 1",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff191D30),
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "00:00",
                  style: TextStyle(fontSize: 20, color: Color(0xffC4CACF)),
                )
              ],
            ),
            SizedBox(height: 3.h),
            CircleAvatar(
                backgroundColor: Color(0xffF2F6F7),
                child: Icon(Icons.add, color: Colors.black)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reminders",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff191D30),
                      fontWeight: FontWeight.w700),
                ),
                Switch(
                  onChanged: toggleSwitch,
                  value: isSwitched,
                  activeColor: Color(0xffCC197D),
                  activeTrackColor: Color(0xffF2F6F7),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Color(0xffF2F6F7),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        //textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        //textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }
}
