import 'package:camera/camera.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flybuy/screens/health/heart_rate.dart';
import 'package:flybuy/screens/health/index.dart';
import 'package:flybuy/screens/health/pill_reminders.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../service/helpers/persist_helper.dart';
import '../../store/setting/setting_store.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  PersistHelper? _persistHelper;
  DateTime? _selectedValue;
  List<CameraDescription> cameras = [];
  String bpm = '';
  late SettingStore _settingStore;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _settingStore = Provider.of<SettingStore>(context);
    _settingStore.persistHelper.getHeartRate().then((value) {
      if (value != null) {
        setState(() {
          bpm = value;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xffCC197D),
            ),
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              decoration: const BoxDecoration(
                  color: Color(0xffF37DBF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 14.0, top: 2.h),
                    child: DatePicker(
                      DateTime.now(),
                      width: 60,
                      height: 90,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.white.withOpacity(0.4),
                      selectedTextColor: Colors.white,
                      dateTextStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      monthTextStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      dayTextStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          _selectedValue = date;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                          color: Color(0xffFFECF7),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          )),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 18.0, right: 18.0, top: 3.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "My Activity",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff8D5F79)),
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HeartRateCalculator(
                                                        cameras: cameras)))
                                        .then((value) {
                                      _settingStore.persistHelper
                                          .getHeartRate()
                                          .then((value) {
                                        print('object$value');
                                        if (value != null) {
                                          setState(() {
                                            bpm = value;
                                          });
                                        }
                                      });
                                    });
                                  },
                                  child: Container(
                                    width: 17.h,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(3.h),
                                            topRight: Radius.circular(3.h),
                                            topLeft: Radius.circular(3.h),
                                            bottomRight: Radius.circular(3.h)),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              const Text(
                                                "Heart Rate",
                                                style: TextStyle(
                                                    color: Color(0xffCC197D),
                                                    fontSize: 18),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                              height: 7.4.h,
                                              child: Center(
                                                child: Image.asset(
                                                    "assets/images/heart.png"),
                                              )),
                                          Text(
                                            bpm!.isNotEmpty ? bpm! : "72",
                                            style: TextStyle(
                                                color: Color(0xffCC197D),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            "BPM",
                                            style: TextStyle(
                                              color: Color(0xffCC197D),
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  },
                                  child: Container(
                                    width: 17.h,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(3.h),
                                            topRight: Radius.circular(3.h),
                                            topLeft: Radius.circular(3.h),
                                            bottomRight: Radius.circular(3.h)),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Pill reminder",
                                                style: TextStyle(
                                                    color: Color(0xffCC197D),
                                                    fontSize: 18),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                              height: 7.4.h,
                                              child: Center(
                                                child: Image.asset(
                                                    "assets/images/meds.png"),
                                              )),
                                          const Text(
                                            "Add",
                                            style: TextStyle(
                                                color: Color(0xffCC197D),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Text(
                                            "Medicine",
                                            style: TextStyle(
                                              color: Color(0xffCC197D),
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  getCamera() async {
    cameras = await availableCameras();
  }
}
