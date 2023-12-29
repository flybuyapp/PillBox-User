import 'package:camera/camera.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flybuy/screens/health/heart_rate.dart';
import 'package:flybuy/screens/health/index.dart';
import 'package:flybuy/screens/health/pill_reminders.dart';
import 'package:flybuy/screens/health/sleep_tracker/home_screen.dart';
import 'package:flybuy/widgets/builder/widgets.dart';
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
  List<Widget> containerList = [];

  List<String> title = ["Heart Rate", "Pill Reminder", "Sleep"];
  List<String> images = [
    "assets/images/heart.png",
    "assets/images/meds.png",
    "assets/images/sleep.png"
  ];
  List<String> fdesc = ['72', "Add", "8/24"];
  List<String> sdesc = ["BPM", "Medicine", "Hours"];
  int? ontap;

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
    containerList.add(InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HeartRateCalculator(cameras: cameras))).then((value) {
            _settingStore.persistHelper.getHeartRate().then((value) {
              print('object$value');
              if (value != null) {
                setState(() {
                  bpm = value;
                });
              }
            });
          });
        },
        child: healthContainer("Heart Rate", "assets/images/heart.png",
            bpm.isNotEmpty ? bpm : "72", "BPM")));

    containerList.add(InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: healthContainer(
            "Pill reminder", "assets/images/meds.png", "Add", "Medicine")));

    containerList.add(
        healthContainer("Sleep", "assets/images/sleep.png", "8/24", "Hours"));
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
                            Expanded(
                              child: GridView.builder(
                                  itemCount: 3,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 2.w,
                                    mainAxisSpacing: 2.w,
                                  ),
                                  itemBuilder: (context, position) {
                                    return InkWell(
                                      onTap: () {
                                        if (position == 0) {
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HeartRateCalculator(
                                                              cameras:
                                                                  cameras)))
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
                                        } else if (position == 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(),
                                              ));
                                        }
                                      },
                                      child: Container(
                                        width: 17.h,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(3.h),
                                                topRight: Radius.circular(3.h),
                                                topLeft: Radius.circular(3.h),
                                                bottomRight:
                                                    Radius.circular(3.h)),
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
                                                  Text(
                                                    title[position],
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffCC197D),
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                  height: 7.4.h,
                                                  child: Center(
                                                    child: Image.asset(
                                                        images[position]),
                                                  )),
                                              Text(
                                                position == 0
                                                    ? bpm
                                                    : fdesc[position],
                                                style: TextStyle(
                                                    color: Color(0xffCC197D),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                sdesc[position],
                                                style: TextStyle(
                                                  color: Color(0xffCC197D),
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
