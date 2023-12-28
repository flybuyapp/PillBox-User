import 'package:flutter/material.dart';
import 'package:flybuy/screens/health/pill_schedule_screen.dart';
import 'package:flybuy/utils/radio_card.dart';
import 'package:sizer/sizer.dart';

class PillReminderScreen extends StatefulWidget {
  const PillReminderScreen({super.key});

  @override
  State<PillReminderScreen> createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController doseController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> timeList = [
    "NeverMind",
    "Before meals",
    "After meals",
    "With food"
  ];

  bool? _selectedIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIcon == false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new),
        actions: const [Icon(Icons.close)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add meditation",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.left,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/tablet.png", height: 15.h, width: 17.w),
                Image.asset("assets/pill.png", height: 15.h, width: 17.w),
                Image.asset("assets/bottle.png", height: 15.h, width: 17.w),
                Image.asset("assets/inheler.png", height: 15.h, width: 17.w),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: double.maxFinite,
              child: TextFormField(
                toolbarOptions: const ToolbarOptions(paste: true),
                //enableInteractiveSelection: true,
                keyboardType: TextInputType.text,
                //enabled: true,
                controller: nameController,
                focusNode: focusNode,
                //autofocus: false,
                showCursor: false,
                //readOnly: false,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
                    hintStyle:
                        TextStyle(color: Color(0xffC4CACF), fontSize: 20)),
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: double.maxFinite,
              child: TextFormField(
                toolbarOptions: ToolbarOptions(paste: true),
                //enableInteractiveSelection: true,
                keyboardType: TextInputType.text,
                //enabled: true,
                controller: doseController,
                focusNode: focusNode,
                //autofocus: false,
                showCursor: false,
                //readOnly: false,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Single dose,e.g.1 tablet",
                    hintStyle:
                        TextStyle(color: Color(0xffC4CACF), fontSize: 20)),
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
            //SizedBox(height: 4.h),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        RadioCard(
                          onTap: () {},
                          active: true,
                          text: timeList[index],
                        ),
                        SizedBox(width: 4.w),
                      ],
                    );
                  }),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PillScheduleScreen()));
                },
                child: Container(
                    width: double.maxFinite,
                    height: 7.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3.h),
                            topRight: Radius.circular(3.h),
                            topLeft: Radius.circular(3.h),
                            bottomRight: Radius.circular(3.h)),
                        color: const Color(0xffF4F4F5)),
                    child: const Center(
                        child: Text(
                      "Fill in the fields",
                      style: TextStyle(fontSize: 16, color: Color(0xffC4CACF)),
                    ))))
          ],
        ),
      ),
    );
  }
}
