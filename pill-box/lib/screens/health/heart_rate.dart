import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/helpers/persist_helper.dart';
import '../../store/setting/setting_store.dart';
//import 'package:wakelock/wakelock.dart';

class HeartRateCalculator extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HeartRateCalculator({Key? key, required this.cameras})
      : super(key: key);

  @override
  _HeartRateCalculatorState createState() => _HeartRateCalculatorState();
}

class _HeartRateCalculatorState extends State<HeartRateCalculator> {
  PersistHelper? _persistHelper;
  bool toggled = false;
  List<SensorValue> alldata = [];
  late CameraController _cameraController =
      CameraController(widget.cameras[0], ResolutionPreset.max);
  bool _processing = false;
  String _start = 'Start';
  double bpm = 0;
  late SettingStore _settingStore;
  double _alpha = 0.3;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _settingStore = Provider.of<SettingStore>(context);
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _cameraController =
          CameraController(_cameras.first, ResolutionPreset.max);
      await _cameraController.initialize();
      Future.delayed(const Duration(milliseconds: 500)).then((onValue) {
        _cameraController.setFlashMode(FlashMode.torch);
      });
      _cameraController.startImageStream((CameraImage image) {
        if (!_processing) {
          setState(() {
            _processing = true;
          });
          _scanImage(image);
        }
      });
    } catch (Exception) {
      print(Exception);
    }
  }

  _scanImage(CameraImage image) {
    double avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    if (alldata.length >= 50) {
      alldata.removeAt(0);
    }
    setState(() {
      alldata.add(SensorValue(
        time: DateTime.now(),
        value: avg,
      ));
    });

    Future.delayed(const Duration(milliseconds: 1000 ~/ 30)).then((onValue) {
      setState(() {
        _processing = false;
      });
    });
  }

  disposeController() {
    _cameraController.dispose();
  }

  toggle() {
    _initController().then((onValue) {
      // Wakelock.enable();
      setState(() {
        toggled = true;
        _processing = false;
      });
      _updateBPM();
    });
  }

  untoggle() {
    disposeController();
    //Wakelock.disable();
    setState(() {
      toggled = false;
      _processing = false;
      _start = 'Start Again';
    });
  }

  _updateBPM() async {
    List<SensorValue> _values;
    double _avg;
    int _n;
    double? _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (toggled) {
      _values = List.from(alldata);
      _avg = 0;
      _n = _values.length;
      _m = 0;
      for (var value in _values) {
        _avg += value.value / _n;
        if (value.value > _m!) _m = value.value.toDouble();
      }
      _threshold = (_m! + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm +=
                60000 / (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        setState(() {
          bpm = (1 - _alpha) * _bpm + _alpha * _bpm;
        });
      }
      await Future.delayed(Duration(milliseconds: (1000 * 50 / 30).round()));
    }
  }

  void onClickSave() {
    Navigator.pop(context, bpm.round());
  }

  void onCalculateBPM() {
    setState(() {
      _start = 'Stop';
    });
    toggle();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffCC197D),
          title: const Text(
            "Calculate Heart Beat",
          ),
        ),
        backgroundColor: const Color(0xFFffffff),
        body: SafeArea(
            child: Container(
                child: Column(
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Text(
                  'Ensure that place your finger on torch and camera before starting. To save heart beat, click on Save.',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          if (toggled) {
                            untoggle();
                            print("untogglleee");
                            _settingStore.persistHelper
                                .setHeartRate(bpm.round().toString());
                          } else {
                            onCalculateBPM();
                          }
                        },
                        child: Text("${_start}")),
                  ),
                  /*SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                _start == 'Start'
                                    ? Colors.grey.shade400
                                    : Colors.red)),
                        onPressed: () {
                          if (_start != 'Start') {
                            onClickSave();
                          }
                        },
                        child: Text("Save")),
                  )*/
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  size: 128,
                  color: Colors.red,
                ),
                const SizedBox(width: 30),
                Text(
                    "${(bpm > 30 && bpm < 150 ? bpm.round().toString() : '0')}",
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.w500)),
                const Text(" bpm"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            alldata.isNotEmpty
                ? Expanded(
                    child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    constraints: BoxConstraints.expand(height: 180),
                    child: BPMChart(alldata),
                  ))
                : SizedBox()
          ],
        ))));
  }
}
