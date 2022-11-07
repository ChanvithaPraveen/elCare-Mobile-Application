// import 'package:elcare_sleep_tracker/emergency_caller/emergency_dialer.dart';
// import 'package:elcare_sleep_tracker/shared_pref/shared_pref_input.dart';
// import 'package:elcare_sleep_tracker/shared_pref/shared_pref_output.dart';
// import 'package:elcare_sleep_tracker/sleep_tracker/sleep_tracker.dart';
import 'package:elcare_application/emergency_caller/emergency_dialer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Person {
  String name;
  String phoneNumber;
  Person(this.name, this.phoneNumber);
}

class EmergencyCaller extends StatefulWidget {
  const EmergencyCaller({Key? key}) : super(key: key);

  @override
  _EmergencyCallerState createState() => _EmergencyCallerState();
}

class _EmergencyCallerState extends State<EmergencyCaller> {
  late final Box box;

  bool _textFieldReadOnly = true;

  Person person1 = new Person("", "");
  Person person2 = new Person("", "");
  Person person3 = new Person("", "");

  TextEditingController nameController1 = TextEditingController();
  TextEditingController phoneNumberController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController phoneNumberController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();
  TextEditingController phoneNumberController3 = TextEditingController();

  _callNumber(String phoneNumber) async {
    if (phoneNumber != "") {
      bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } else if (person1.phoneNumber != "") {
      bool? res =
          await FlutterPhoneDirectCaller.callNumber(person1.phoneNumber);
    } else if (person2.phoneNumber != "") {
      bool? res =
          await FlutterPhoneDirectCaller.callNumber(person2.phoneNumber);
    } else if (person3.phoneNumber != "") {
      bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Contact Number is Saved!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Hurry!'),
                  Text('Press the following button to dial manually'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Dial'),
                onPressed: () {
                  print("Hello");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmergencyDialer()),
                  );
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  _saveContacts() async {
    if (person1.name != "") {
      _addInfo('person1Name', person1.name);
    }
    if (person2.name != "") { 
      _addInfo('person2Name', person2.name);
    }
    if (person3.name != "") {
      _addInfo('person3Name', person3.name);
    }
    if (person1.phoneNumber != "") {
      _addInfo('person1Phone', person1.phoneNumber);
    }
    if (person2.phoneNumber != "") {
      _addInfo('person2Phone', person2.phoneNumber);
    }
    if (person3.phoneNumber != "") {
      _addInfo('person3Phone', person3.phoneNumber);
    }

    _addInfo('person1Name', person1.name);
    _addInfo('person2Name', person2.name);
    _addInfo('person3Name', person3.name);
    _addInfo('person1Phone', person1.phoneNumber);
    _addInfo('person2Phone', person2.phoneNumber);
    _addInfo('person3Phone', person3.phoneNumber);
  }

  String? nameName = "";

  dynamic _getContactInfo(String key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('$key');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box("emergencyContactBox");
    Hive.openBox("emergencyContactBox");
    if (_getInfo("person1Name") != null) {
      nameController1.text = _getInfo("person1Name");
      person1.name = _getInfo("person1Name");
    }
    if (_getInfo("person2Name") != null) {
      nameController2.text = _getInfo("person2Name");
      person2.name = _getInfo("person2Name");
    }
    if (_getInfo("person3Name") != null) {
      nameController3.text = _getInfo("person3Name");
      person3.name = _getInfo("person3Name");
    }
    if (_getInfo("person1Phone") != null) {
      phoneNumberController1.text = _getInfo("person1Phone");
      person1.phoneNumber = _getInfo("person1Phone");
    }
    if (_getInfo("person2Phone") != null) {
      phoneNumberController2.text = _getInfo("person2Phone");
      person2.phoneNumber = _getInfo("person2Phone");
    }
    if (_getInfo("person3Phone") != null) {
      phoneNumberController3.text = _getInfo("person3Phone");
      person3.phoneNumber = _getInfo("person3Phone");
    }
  }

  @override
  void dispose() {
    // Closes all Hive boxes
    //Hive.close();
    super.dispose();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  _addInfo(String key, String value) async {
    box.put(key, value);
  }

  _getInfo(String key) {
    return box.get(key);
  }

  _updateInfo(String key, String value) {
    box.put(key, value);
  }

  _deleteInfo(key) {
    box.delete(key);
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff232526), Color(0xff414345)])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Emergency Caller",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Column(
                      children: [
                        Text(
                          "Contact #1",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: nameController1,
                          onChanged: (String value) {
                            person1.name = value;
                            _saveContacts();
                          },
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          decoration: new InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                            hintText: 'Name of the Person',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          readOnly: _textFieldReadOnly,
                        ),
                        SizedBox(height: 10),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            // IconButton(onPressed: () {}, icon: Icon(Icons.call), color: Colors.red,),
                            TextButton.icon(
                              onPressed: () {
                                _callNumber(person1.phoneNumber);
                              },
                              icon: Icon(Icons.call),
                              label: Text('Call'),
                              style: TextButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                            ),
                            Expanded(
                                child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController1,
                              onChanged: (String value) {
                                person1.phoneNumber = value;
                                _saveContacts();
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              decoration: new InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                hintText: 'Contact Number',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              readOnly: _textFieldReadOnly,
                            )),
                          ],
                        ),
                        Divider(color: Colors.white),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Column(
                      children: [
                        Text(
                          "Contact #2",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: nameController2,
                          onChanged: (String value) {
                            person2.name = value;
                            _saveContacts();
                          },
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          decoration: new InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                            hintText: 'Name of the Person',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          readOnly: _textFieldReadOnly,
                        ),
                        SizedBox(height: 10),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            // IconButton(onPressed: () {}, icon: Icon(Icons.call), color: Colors.red,),
                            TextButton.icon(
                              onPressed: () {
                                _callNumber(person2.phoneNumber);
                              },
                              icon: Icon(Icons.call),
                              label: Text('Call'),
                              style: TextButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                            ),
                            Expanded(
                                child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController2,
                              onChanged: (String value) {
                                person2.phoneNumber = value;
                                _saveContacts();
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              decoration: new InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                hintText: 'Contact Number',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              readOnly: _textFieldReadOnly,
                            )),
                          ],
                        ),
                        Divider(color: Colors.white),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    Column(
                      children: [
                        Text(
                          "Contact #3",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: nameController3,
                          onChanged: (String value) {
                            person3.name = value;
                            _saveContacts();
                          },
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          decoration: new InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                            hintText: 'Name of the Person',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          readOnly: _textFieldReadOnly,
                        ),
                        SizedBox(height: 10),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            // IconButton(onPressed: () {}, icon: Icon(Icons.call), color: Colors.red,),
                            TextButton.icon(
                              onPressed: () {
                                _callNumber(person3.phoneNumber);
                              },
                              icon: Icon(Icons.call),
                              label: Text('Call'),
                              style: TextButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                            ),
                            Expanded(
                                child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController3,
                              onChanged: (String value) {
                                person3.phoneNumber = value;
                                _saveContacts();
                              },
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              decoration: new InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                hintText: 'Contact Number',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              readOnly: _textFieldReadOnly,
                            )),
                          ],
                        ),
                        Divider(color: Colors.white),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _textFieldReadOnly = false;
                              // box.clear();
                            });
                          },
                          icon: Icon(Icons.edit),
                          label: Text('Edit'),
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.tealAccent[700]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            setState(() {
                              _textFieldReadOnly = true;
                            });

                            _saveContacts();
                          },
                          icon: Icon(Icons.save_outlined),
                          label: Text('Save'),
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.blueAccent[700]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
