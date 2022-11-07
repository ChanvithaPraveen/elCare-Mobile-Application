import 'dart:async';
import 'dart:io';
import 'dart:math';

// import 'package:elcare_sleep_tracker/emergency_caller/emergency_caller.dart';
// import 'package:elcare_sleep_tracker/sleep_quality_model.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker_db.dart';
import 'package:elcare_application/emergency_caller/emergency_caller.dart';
import 'package:elcare_application/regular_user_menu.dart';
import 'package:flutter/material.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:light/light.dart';
import 'package:flutter_dnd/flutter_dnd.dart';

class SleepTracker extends StatefulWidget {
  const SleepTracker({Key? key}) : super(key: key);

  @override
  _SleepTrackerState createState() => _SleepTrackerState();
}

class _SleepTrackerState extends State<SleepTracker>
    with WidgetsBindingObserver {
  late final Box sleepQualityBox;
  late final Box sleepDurationBox;


final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();




  final CustomTimerController _controller = new CustomTimerController();
  bool isStarted = false;
  var now = DateTime.now();
  var wakeTime1 = DateTime.now().add(const Duration(minutes: 15 + 90));
  var wakeTime2 = DateTime.now().add(const Duration(minutes: 15 + (90 * 2)));
  var wakeTime3 = DateTime.now().add(const Duration(minutes: 15 + (90 * 3)));
  var wakeTime4 = DateTime.now().add(const Duration(minutes: 15 + 90 * 4));
  var wakeTime5 = DateTime.now().add(const Duration(minutes: 15 + 90 * 5));
  var wakeTime = DateTime.now();

  /////////////////////////////////////
  //do not distrub
  String dndModeTo = "on";
  bool isDNDOn = false;
  String _filterName = '';
  bool _isNotificationPolicyAccessGranted = false;

  ///////////////////////////////////////
  String isRoomSuitable = "Suitable";

  ////////////////////////////////////////
  //this is for light calculations
  int max_light = 0;
  int low_light = 500;
  double avg_lux = 150;
  String? _luxString = 'Unknown';
  late Light _light;
  late StreamSubscription _subscription;

  void onData(int luxValue) async {
    //print("Lux value: $luxValue");
    if(mounted){
setState(() {
      _luxString = "$luxValue";
      if (luxValue <= 10) {
        if (luxValue < 5) {
          low_light = luxValue;
          print(low_light);
        }
        if (luxValue >= 5 && luxValue <= 10) {
          max_light = luxValue;
        }
        avg_lux = (low_light + max_light) / 2.0;
      }
      //print(avg_lux);
      /////////////TO make sure that the room is good
      ///before sleep the room lux must be less than 180
      ///while sleep room lux must be less than 10

      if (!isStarted) {
        if (luxValue > 180) {
          isRoomSuitable = "not Suitable";
        } else {
          isRoomSuitable = "Suitable";
        }
      } else {
        if (luxValue > 10) {
          isRoomSuitable = "not Suitable";
        } else {
          isRoomSuitable = "Suitable";
        }
      }
    });
    }
    
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    //Hive.openBox("emergencyContactBox");
    //light
    super.initState();
    initPlatformState();
    //do not disturb
    WidgetsBinding.instance?.addObserver(this);
    super.initState();

    //hive database
    sleepQualityBox = Hive.box('sleepQualityBox'); //box 1
    sleepDurationBox = Hive.box('sleepDurationBox'); //box 2
    Hive.openBox('sleepQualityBox');
    Hive.openBox('sleepDurationBox');
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  _addInfo(String key, String value, int boxNum) async {
    if (boxNum == 1) {
      sleepQualityBox.put(key, value);
    } else {
      sleepDurationBox.put(key, value);
    }
  }

  _getInfo(String key, int boxNum) {
    if (boxNum == 1) {
      return sleepQualityBox.get(key);
    } else {
      return sleepDurationBox.get(key);
    }
  }

  _updateInfo(String key, String value, int boxNum) {
    if (boxNum == 1) {
      sleepQualityBox.put(key, value);
    } else {
      sleepDurationBox.put(key, value);
    }
  }

  _deleteInfo(key, int boxNum) {
    if (boxNum == 1) {
      sleepQualityBox.delete(key);
    } else {
      sleepDurationBox.delete(key);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // @override
  // void dispose() {
  //   // Closes all Hive boxes
  //   //Hive.close();
  //   super.dispose();
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  /////////////////////////////////////////
  ///do not disturb
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state.toString());
    if (state == AppLifecycleState.resumed) {
      updateUI();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateUI();
  }

  void updateUI() async {
    int? filter = await FlutterDnd.getCurrentInterruptionFilter();
    String filterName = FlutterDnd.getFilterName(filter!);
    bool? isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;

    setState(() {
      _isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted!;
      _filterName = filterName;
      if (isDNDOn) {
        isDNDOn = false;
        dndModeTo = "on";
      } else {
        isDNDOn = true;
        dndModeTo = "off";
      }
    });
  }

  void setInterruptionFilter(int filter) async {
    if (await FlutterDnd.isNotificationPolicyAccessGranted??false) {
      await FlutterDnd.setInterruptionFilter(filter);
      updateUI();
    }
  }

  /////////////////////////////////////////
  var wakeMinute = 15 + 90; //this is for the timer starting point
  var wakeUpHour = 0;
  var wakeUpMinute = 0;

  //to calculate the time that was recorded when pressed stop
  var timerBeginTime = DateTime.now();
  var timerStoppedTime = DateTime.now();
  //var timerRunTime = 0;

  //time picker
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 0);
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        wakeUpHour = _time.hour;
        wakeUpMinute = _time.minute;
        TimeOfDay t = TimeOfDay.now();

        int nowMinute = t.minute + t.hour * 60;
        int thenMinute = wakeUpHour * 60 + wakeUpMinute;

        if (thenMinute > nowMinute) {
          wakeMinute = thenMinute - nowMinute;
        } else {
          wakeMinute = (24 * 60 - nowMinute) + wakeMinute;
        }
      });
      _controller.reset();
      // _controller.start();
      // _controller.pause();
    }
  }

  void timerStoppedOrFinishedFunction() {



var heyDay;
    for(int i=1; i<=10;i++){
      heyDay =  DateTime.now().add( Duration(days:i));
      _addInfo("${heyDay.year}-${heyDay.month}-${heyDay.day} 00:00:00.000", "${i*9}", 1);
      _addInfo("${heyDay.year}-${heyDay.month}-${heyDay.day} 00:00:00.000", "${i*9}", 2);
    }

    print("Data added");






    int sleepQuality = calculateSleepQuality().ceil();

    //database
    DateTime timerStoppedDate = DateTime.now();
    String dateToInput =
        "${timerStoppedDate.year}-${timerStoppedDate.month}-${timerStoppedDate.day} 00:00:00.000";
    if (_getInfo(dateToInput, 1) == null ||
        int.parse(_getInfo(dateToInput, 1)) < sleepQuality) {
      _addInfo(dateToInput, "$sleepQuality", 1);
    }

    double prevDuration = 0;
    if (_getInfo(dateToInput, 2) != null) {
      prevDuration = double.parse(_getInfo(dateToInput, 2));
    }

    double todayDuration = prevDuration + getTimerRunTime() / 60;
    _addInfo(dateToInput, "$todayDuration", 2);

    // _addInfo("2021/11/1", "85", 2);
    // _addInfo("2021/11/2", "85", 2);
    // _addInfo("2021/11/3", "85", 2);
    // _addInfo("2021/11/4", "85", 2);
    // _addInfo("2021/11/5", "85", 2);
    // _addInfo("2021/11/6", "85", 2);
    // _addInfo("2021/11/7", "85", 2);
    // _addInfo("2021/11/8", "85", 2);
    // _addInfo("2021/11/9", "85", 2);
    // _addInfo("2021/11/10", "85", 2);

    // _addInfo("2021/11/1", "85", 1);
    // _addInfo("2021/11/2", "85", 1);
    // _addInfo("2021/11/3", "85", 1);
    // _addInfo("2021/11/4", "85", 1);
    // _addInfo("2021/11/5", "85", 1);
    // _addInfo("2021/11/6", "85", 1);
    // _addInfo("2021/11/7", "85", 1);
    // _addInfo("2021/11/8", "85", 1);
    // _addInfo("2021/11/9", "85", 1);
    // _addInfo("2021/11/10", "85", 1);

// print("=========================================================================");
// print("=========================================================================");
// print("=========================================================================");
// print("=========================================================================");
// print("=========================================================================");
//     print(sleepDurationBox.keys);
//     print(sleepDurationBox.values);
//     print(sleepQualityBox.values);
//     print(sleepQualityBox.keys);

// print("=========================================================================");
// print("=========================================================================");
// print("=========================================================================");
// print("=========================================================================");
// print("=========================================================================");

    //playing ringtone
    //FlutterRingtonePlayer.playAlarm(looping:true, asAlarm:true);
    FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 1, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );

    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Hello!'),
        content: Text('Your sleep quality is $sleepQuality%'),
        actions: <Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.black,
                //backgroundColor: Colors.amber,
              ),
              onPressed: () {
                FlutterRingtonePlayer.stop();
                Get.off(()=>RegularUserMain());
                // Navigator.pop(context, 'Cancel');
                
                // SleepQualityModel sleepQualityModel = SleepQualityModel(percentage: sleepQuality,date: DateTime.now());
                // SleepTrackerDatabase.instance.create(sleepQualityModel);
                //////
                ///
                // Future<List<SleepQualityModel>> n = SleepTrackerDatabase.instance.readAllSleepData();
                // print(n.toString());
                ///
                ///
              },
              icon: Icon(Icons.save),
              label: Text('Save and Return to Home')),
        ],
      ),
    );
  }

  //calculating sleep quality
  double calculateSleepQuality() {
    double sleepCycleQualityPercentage = 0;
    double numberOfSleepCyclesQuality = 0;
    double lightQuality = 0;
    double sleepQualityFinal = 0;
    int runTime =
        getTimerRunTime() - 15; //sunbstract 15-> time taken to fall asleep

    //sleep cycle quality percentage
    if (runTime >= 90) {
      int x = wakeMinute % 90;
      //sleep cycle quality percentage
      if (x >= 0 && x <= 10) {
        //waking at the begin of a sleep cycle 0->100% 10->80%
        sleepCycleQualityPercentage = (x * (80 - 100) / 10.0) + 100;
      } else if (x >= 80 && x <= 90) {
        //waking at the end of a sleep cycle 80->80% 90->100%
        sleepCycleQualityPercentage = 2 * x - 80;
      } else {
        //waking at the middle of a sleep cycle
        if (x <= 45) {
          sleepCycleQualityPercentage = (((10 - x) * 80) / 35.0) + 80;
        } else {
          sleepCycleQualityPercentage = (80 * (x - 45)) / 35.0;
        }
      }
    }
    //number of sleep cycle quality percentage
    numberOfSleepCyclesQuality = (runTime / 90 * 5) * 100;
    if (numberOfSleepCyclesQuality > 100) {
      numberOfSleepCyclesQuality = 100;
    }
    if (numberOfSleepCyclesQuality < 0) {
      numberOfSleepCyclesQuality = 0;
    }
    //light quality
    if (avg_lux == 150 || runTime <= 15) {
      lightQuality = 0;
    } else {
      lightQuality = 100 - 2 * avg_lux;
    }
    sleepQualityFinal = (sleepCycleQualityPercentage +
            numberOfSleepCyclesQuality +
            lightQuality) /
        3;
    return sleepQualityFinal;
  }

  //get timer run time
  int getTimerRunTime() {
    var timerRunTime = 0;
    timerStoppedTime = DateTime.now();
    var timerStoppedMin = timerStoppedTime.hour * 60 + timerStoppedTime.minute;
    var timerBeginMinute = timerBeginTime.hour * 60 + timerBeginTime.minute;
    if (timerStoppedMin > timerBeginMinute) {
      timerRunTime = timerStoppedMin - timerBeginMinute;
    } else {
      timerRunTime = (24 * 60 - timerBeginMinute) + timerStoppedMin;
    }
    if (timerRunTime >= 1400) {
      timerRunTime = 0;
    }
    //print("run time $timerRunTime");
    return timerRunTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fonts/images/loginback.jpg"),
              fit: BoxFit.cover),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff232526), Color(0xff414345)]),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Select wake up Time",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Colors.black,
                                title: const Text(
                                  'Select Wake Up Time',
                                  style: TextStyle(color: Colors.white),
                                ),
                                scrollable: true,
                                content: Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                        style: TextButton.styleFrom(
                                            primary: Colors.greenAccent[400],
                                            //backgroundColor: Colors.amber,
                                            textStyle: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        onPressed: () {
                                          setState(() {
                                            isStarted = false;
                                            wakeMinute = 15 + 90;
                                            _controller.reset();
                                            wakeUpMinute = wakeTime1.minute;
                                            wakeUpHour = wakeTime1.hour;
                                            Navigator.pop(context, 'Cancel');
                                          });
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text(wakeTime1.hour.toString() +
                                            ":" +
                                            wakeTime1.minute.toString() +
                                            " (for light sleepers)")),
                                    TextButton.icon(
                                        style: TextButton.styleFrom(
                                            primary: Colors.greenAccent[400],
                                            //backgroundColor: Colors.amber,
                                            textStyle: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        onPressed: () {
                                          setState(() {
                                            isStarted = false;
                                            wakeMinute = 15 + 90 * 2;
                                            wakeUpMinute = wakeTime2.minute;
                                            wakeUpHour = wakeTime2.hour;

                                            Navigator.pop(context, 'Cancel');
                                          });
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text(wakeTime2.hour.toString() +
                                            ":" +
                                            wakeTime2.minute.toString() +
                                            " (for light sleepers)")),
                                    TextButton.icon(
                                        style: TextButton.styleFrom(
                                            primary: Colors.blueAccent[400],
                                            //backgroundColor: Colors.amber,
                                            textStyle: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        onPressed: () {
                                          setState(() {
                                            isStarted = false;
                                            wakeMinute = 15 + 90 * 3;
                                            wakeUpMinute = wakeTime3.minute;
                                            wakeUpHour = wakeTime3.hour;
                                            Navigator.pop(context, 'Cancel');
                                          });
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text(wakeTime3.hour.toString() +
                                            ":" +
                                            wakeTime3.minute.toString() +
                                            " (for medium sleepers)")),
                                    TextButton.icon(
                                        style: TextButton.styleFrom(
                                            primary: Colors.orangeAccent[400],
                                            //backgroundColor: Colors.amber,
                                            textStyle: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        onPressed: () {
                                          setState(() {
                                            isStarted = false;
                                            wakeMinute = 15 + 90 * 4;
                                            wakeUpMinute = wakeTime4.minute;
                                            wakeUpHour = wakeTime4.hour;
                                            Navigator.pop(context, 'Cancel');
                                          });
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text(wakeTime4.hour.toString() +
                                            ":" +
                                            wakeTime4.minute.toString() +
                                            " (for heavy sleepers)")),
                                    TextButton.icon(
                                        style: TextButton.styleFrom(
                                            primary: Colors.redAccent[400],
                                            //backgroundColor: Colors.amber,
                                            textStyle: TextStyle(
                                                fontStyle: FontStyle.italic)),
                                        onPressed: () {
                                          setState(() {
                                            isStarted = false;
                                            wakeMinute = 15 + 90 * 5;
                                            wakeUpMinute = wakeTime5.minute;
                                            wakeUpHour = wakeTime5.hour;
                                            Navigator.pop(context, 'Cancel');
                                          });
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text(wakeTime5.hour.toString() +
                                            ":" +
                                            wakeTime5.minute.toString() +
                                            " (for heavy sleepers)")),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => {
                                      setState(() {
                                        isStarted = false;
                                      }),
                                      Navigator.pop(context, 'Cancel'),
                                      _controller.reset()
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  // TextButton(
                                  //   onPressed: () => Navigator.pop(context, 'OK'),
                                  //   child: const Text('OK'),
                                  // ),
                                ],
                              ),
                            );
                            _controller.reset();
                            setState(() {
                              isStarted = false;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent)),
                          child: Text('Suggested',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: _selectTime,
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber)),
                          child: Text('Custom',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Wake up at ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Text('$wakeUpHour.$wakeUpMinute',
                            style: TextStyle(color: Colors.white, fontSize: 20))
                      ],
                    ),
                    SizedBox(height: 10),
                    TextButton.icon(
                        onPressed: () {
                          if (!_isNotificationPolicyAccessGranted) {
                            FlutterDnd.gotoPolicySettings();
                          } else {
                            if (!isDNDOn) {
                              setInterruptionFilter(
                                  FlutterDnd.INTERRUPTION_FILTER_ALARMS);
                            } else {
                              setInterruptionFilter(
                                  FlutterDnd.INTERRUPTION_FILTER_ALL);
                            }
                          }
                        },
                        icon: Icon(Icons.do_not_disturb_rounded),
                        label: Text('Turn $dndModeTo do not disturb mode')),
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor:
                            isStarted ? Colors.amber : Colors.white,
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              onPressed: () {
                                if (isStarted) {
                                  _controller.pause();
                                  setState(() {
                                    isStarted = false;
                                  });
                                } else {
                                  _controller.start();

                                  setState(() {
                                    isStarted = true;
                                    timerBeginTime = DateTime.now();
                                  });
                                }
                              },
                              icon: Icon(isStarted
                                  ? Icons.pause
                                  : Icons.play_arrow_rounded),
                              highlightColor: Colors.red,
                              iconSize: 50,
                              color: Colors.white,
                              padding: EdgeInsets.zero,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomTimer(
                          onFinish: () {
                            timerStoppedOrFinishedFunction();
                          },
                          controller: _controller,
                          from: Duration(minutes: wakeMinute),
                          to: Duration(hours: 0),
                          interval: Duration(seconds: 1),
                          builder: (CustomTimerRemainingTime remaining) {
                            return Text(
                              "${remaining.hours}:${remaining.minutes}:${remaining.seconds}",
                              style: TextStyle(
                                  fontSize: 50.0, color: Colors.white),
                            );
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                                style: TextButton.styleFrom(
                                    primary: Colors.red,
                                    //backgroundColor: Colors.amber,
                                    textStyle:
                                        TextStyle(fontStyle: FontStyle.italic)),
                                onPressed: () {
                                  _controller.reset();
                                  if (isStarted) {
                                    setState(() {
                                      isStarted = false;
                                      // timerStoppedTime = DateTime.now();
                                      // var timerStoppedMin =
                                      //     timerStoppedTime.hour * 60 +
                                      //         timerStoppedTime.minute;
                                      // var timerBeginMinute =
                                      //     timerBeginTime.hour * 60 +
                                      //         timerBeginTime.minute;
                                      // if (timerStoppedMin > timerBeginMinute) {
                                      //   timerRunTime =
                                      //       timerStoppedMin - timerBeginMinute;
                                      // } else {
                                      //   timerRunTime =
                                      //       (24 * 60 - timerBeginMinute) +
                                      //           timerStoppedMin;
                                      // }
                                      setInterruptionFilter(
                                          FlutterDnd.INTERRUPTION_FILTER_ALL);
                                    });
                                    timerStoppedOrFinishedFunction();
                                    //print("stop pressed");
                                    //print(getTimerRunTime());
                                  } else {
                                    () {
                                      null;
                                    };
                                  }
                                },
                                icon: Icon(Icons.stop_circle),
                                label: Text('Stop')),
                          ],
                        )
                      ],
                    ),
                  ])),
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: Colors.white,
                        ),
                        Text('$_luxString lux',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          width: 10,
                        ),
                        // Icon(
                        //   Icons.surround_sound,
                        //   color: Colors.white,
                        // ),
                        // Text('45dB', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Text('Room is $isRoomSuitable for a good sleep',
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EmergencyCaller()));
        },
        child: const Icon(Icons.call),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
