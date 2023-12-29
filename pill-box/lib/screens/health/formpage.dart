import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flybuy/screens/health/index.dart';
import 'package:flybuy/utils/stringtext.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../models/pill_reminder/date.dart';
import '../../models/pill_reminder/pill.dart';
import '../../utils/buttons.dart';
import '../../utils/radio_card.dart';
import '../../utils/textfield.dart';

class FormPage extends StatefulWidget {
  FormPage({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formState = {
    'title': '',
    'weight': 0,
    'span': 0,
    'dosage': 0,
    'morning': null,
    'afternoon': null,
    'evening': null,
    'food': null,
  };

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TimeOfDay? timeOfDay;
  List images = ['pill.png', 'tablet.png', 'bottle.png', 'inheler.png'];
  DateTime now = new DateTime.now();
  List<TimeOfDay> times = [];
  String _selectedImage = 'pill.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffFFECF7),
          leading: Material(
            color: Color(0xffFFECF7),
            child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => {Navigator.pop(context)},
                child: const Icon(Iconsax.arrow_left_2)),
          ),
          title: const Text(
            'Add reminder',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            /*const Positioned.fill(
              child: GridBackground(),
            ),*/
            /*Positioned(
              top: 80,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Image.asset(
                  "assets/images/Pill.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),*/

            Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 30,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(),
              ),
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  SingleChildScrollView(
                    //controller: scrollController,
                    child: Form(
                      key: widget._formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedImage = images[index];
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                _selectedImage == images[index]
                                                    ? Colors.pink
                                                    : Colors.transparent,
                                            width: 4),
                                      ),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.20,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Image.asset(
                                          "assets/images/${images[index]}",
                                          //fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            titleForm(),
                            weightForm(),
                            amountAndSpanForm(),
                            notificationsForm(),
                            ButtonWidget(
                                text: const Text(
                                  'Done',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                onPressed: () async {
                                  if (times.isNotEmpty) {
                                    for (TimeOfDay? time in times) {
                                      print('time ::: $time :::${time}');
                                      if (time == null) {
                                        continue;
                                      }
                                      Pill pill = Pill.fromJson({
                                        ...widget.formState,
                                        'time': time,
                                        'title': widget.formState['title'],
                                        'description': '',
                                        'food': widget.formState['food'],
                                        'image': _selectedImage
                                      });
                                      print(pill.toJson());
                                      await Provider.of<DataModel>(context,
                                              listen: false)
                                          .add(pill);
                                    }

                                    await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  }
                                  /* if (widget._formKey.currentState!
                                          .validate() &&
                                      [
                                        widget.formState['morning'],
                                        widget.formState['afternoon'],
                                        widget.formState['evening']
                                      ].any((element) {
                                        log("=:=:element:=:==${element}");
                                        if (element != null) {
                                          setState(() {
                                            timeOfDay = element;
                                          });
                                        }
                                        return element != null;
                                      })) {
                                    widget._formKey.currentState?.save();
                                    List<TimeOfDay> times = [timeOfDay!];
                                    widget.formState.remove('morning');
                                    widget.formState.remove('afternoon');
                                    widget.formState.remove('evening');
                                    for (TimeOfDay? time in times) {
                                      if (time == null) {
                                        continue;
                                      }
                                      Pill pill = Pill.fromJson({
                                        ...widget.formState,
                                        'time': time,
                                        'description': '',
                                        'food': widget.formState['food']
                                      });
                                      print(pill.toJson());
                                      await Provider.of<DataModel>(context,
                                          listen: false)
                                          .add(pill);
                                    }

                                    await Navigator.of(context)
                                        .pushNamed(RouteManager.homePage);

                                  }*/
                                })
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Column notificationsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Food',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['food'] =
                          ((widget.formState['food'] == null)
                              ? 'Never Mind'
                              : 'Never Mind');
                    });
                  },
                  active: (widget.formState['food'] == 'Never Mind'),
                  text: 'Never Mind'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['food'] =
                          ((widget.formState['food'] == null)
                              ? 'Before Meals'
                              : 'Before Meals');
                    });
                  },
                  active: (widget.formState['food'] == 'Before Meals'),
                  text: 'Before Meals'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['food'] =
                          ((widget.formState['food'] == null)
                              ? 'After Meals'
                              : 'After Meals');
                    });
                  },
                  active: (widget.formState['food'] == 'After Meals'),
                  text: 'After Meals'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['food'] =
                          ((widget.formState['food'] == null)
                              ? 'With Food'
                              : 'With Food');
                    });
                  },
                  active: (widget.formState['food'] == 'With Food'),
                  text: 'With Food'),
            )
          ],
        ),
        SizedBox(height: 23),
        const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: times.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: RadioCard(
                        text:
                            '${times[index].hourOfPeriod} :${times[index].minute.toString().padLeft(2, '0')} ${times[index].period.name.toUpperCase()}',
                        active: true,
                        onTap: () {},
                      ),
                    ); /*Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width *
                            0.20,
                        height:
                        MediaQuery
                            .of(context)
                            .size
                            .height *
                            0.4,
                        child: Text(
                            '${times[index].hour} :${times[index].minute}',
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .onSurface
                            )),
                      ),
                    );*/
                  },
                )
                /*RadioCard(
                  onTap: () {
                    setState(() {
                      widget.formState['food'] =
                          ((widget.formState['food'] == null)
                              ? 'Never Mind'
                              : 'Never Mind');
                    });
                  },
                  active: (widget.formState['food'] == 'Never Mind'),
                  text: 'Never Mind'),*/
                ),
            /* Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      */ /*widget.formState['morning'] =
                          ((widget.formState['morning'] == null)
                              ? const TimeOfDay(hour: 7, minute: 0)
                              : null);*/ /*
                    });
                  },
                  active: (widget.formState['morning'] != null),
                  text: '7:00 AM'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    */ /*setState(() {
                      widget.formState['afternoon'] =
                          ((widget.formState['afternoon'] == null)
                              ? const TimeOfDay(hour: 13, minute: 0)
                              : null);
                    });*/ /*
                  },
                  active: (widget.formState['afternoon'] != null),
                  text: '1:00 PM'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: RadioCard(
                  onTap: () {
                    setState(() {
                      */ /*widget.formState['evening'] =
                          ((widget.formState['evening'] == null)
                              ? const TimeOfDay(hour: 19, minute: 0)
                              : null);*/ /*
                    });
                  },
                  active: (widget.formState['evening'] != null),
                  text: '7:00 PM'),
            ),*/
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                showDatePickerNextVaccinationDate();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.20,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffCC197D), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row amountAndSpanForm() {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
              onSave: (val) {
                setState(() {
                  widget.formState['dosage'] = int.parse(val);
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              inputType: TextInputType.number,
              validator: (val) {
                if (val == null) {
                  return null;
                } else if (!val.isValidNumber) {
                  return 'Enter valid amount';
                }
                return null;
              },
              icon: Iconsax.copy,
              hint: '1 pill'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFieldWidget(
              onSave: (val) {
                setState(() {
                  widget.formState['span'] = int.parse(val);
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              inputType: TextInputType.number,
              validator: (val) {
                if (val == null) {
                  return null;
                } else if (!val.isValidNumber) {
                  return 'Enter valid time interval';
                }
                return null;
              },
              icon: Iconsax.calendar_1,
              hint: '21 days'),
        )
      ],
    );
  }

  Column weightForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weight',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        TextFieldWidget(
            onSave: (val) {
              setState(() {
                widget.formState['weight'] = int.parse(val);
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[0-9]"),
              )
            ],
            inputType: TextInputType.number,
            validator: (val) {
              if (val == null) {
                return null;
              } else if (!val.isValidNumber) {
                return 'Enter valid weight';
              }
              return null;
            },
            icon: Iconsax.weight,
            hint: '69 mg'),
        const Text(
          'Amount & How Long?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }

  Column titleForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pills name',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        TextFieldWidget(
            onSave: (val) {
              setState(() {
                widget.formState['title'] = val;
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r"[a-zA-Z]+|\s"),
              )
            ],
            inputType: TextInputType.text,
            validator: (val) {
              if (val == null) {
                return null;
              } else if (!val.isValidName) {
                return 'Enter valid Pill Name';
              }
              return null;
            },
            icon: Icons.medical_services_outlined,
            hint: 'Probiotic'),
      ],
    );
  }

  void showDatePickerNextVaccinationDate() {
    DateTime minDate = DateTime(now.year, now.month, now.day);
    DateTime maxDate = DateTime(now.year + 12, now.month, now.day);
    DateTime _selectedDueDate = DateTime.now();
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.pink,
            height: 300.0,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      child: Text(
                        "Cancel",
                      ),
                      onPressed: () => {Navigator.pop(context)},
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      child: Text(
                        "Done",
                      ),
                      onPressed: () {
                        setState(() {
                          times.add(TimeOfDay(
                              hour: _selectedDueDate.hour,
                              minute: _selectedDueDate.minute));
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Flexible(
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    minimumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (date) {
                      setState(() {
                        print(date);
                        _selectedDueDate = date;
                      });
                    },
                  ),
                ),
              ],
            ),
          );

          /*showCupertinoModalPopup(
        context: context,

        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.50,
            color: Colors.pink,
            child: CupertinoDatePicker(
              maximumYear: now.year + 12,
              minimumYear: now.year,
              mode: CupertinoDatePickerMode.time,
              initialDateTime: minDate,

              onDateTimeChanged: (value) {
                  setState(() {
                    times.add(TimeOfDay(hour: value.hour, minute: value.minute));
                  });
              },
              maximumDate: maxDate,
              minimumDate: minDate,

            ),
          );
        });*/
        });
  }
}
