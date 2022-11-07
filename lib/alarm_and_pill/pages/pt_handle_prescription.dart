// ignore_for_file: non_constant_identifier_names, duplicate_ignore

// import 'package:el_care_piltimer/services/PrescriptionB.dart';
// import 'package:alarm_manager/Alarm_Data/editable_lists.dart';
// import 'package:alarm_manager/db/medi_database.dart';
// import 'package:alarm_manager/services/MediData.dart';
// import 'package:alarm_manager/services/Medicine.dart';
// import 'package:alarm_manager/services/Prescription.dart';

import 'package:elcare_application/alarm_and_pill/Alarm_Data/editable_lists.dart';
import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/pages/pt_view_prescription.dart';
import 'package:elcare_application/alarm_and_pill/services/MediData.dart';
import 'package:elcare_application/alarm_and_pill/services/Medicine.dart';
import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

void main() => runApp(const MaterialApp(
      home: HandlePrescription(),
    ));

class HandlePrescription extends StatefulWidget {
  const HandlePrescription({Key? key}) : super(key: key);

  @override
  _HandlePrescriptionState createState() => _HandlePrescriptionState();
}

int numOfDays = 1;

class _HandlePrescriptionState extends State<HandlePrescription> {
  bool status = true;
  List<String> items_list = <String>[];
  String item = 'Penadol';
  late String newDays = '0';
  //int numOfDays = 0;
  List<MediData> medicines = [];

  @override
  void initState() {
    super.initState();
    refreshMediData();
  }

  // ignore: non_constant_identifier_names
  List<int> quantity_list = <int>[1, 2, 3, 4, 5, 6, 7];
  int quantity = 1;

  List<String> add_item = <String>[];
  List<int> add_quantity = <int>[];
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();

  get mainAxisAlignment => null;

  Future refreshMediData() async {
    setState(() => isLoading = true);
    WidgetsFlutterBinding.ensureInitialized();
    this.medicines = await AppDatabase.instance.readAllMediData();
    setupItemsList();
    setState(() => isLoading = false);
  }

  //create string name array
  void setupItemsList() {
    print(medicines.length);
    for (int i = 0; i < medicines.length; i++) {
      items_list.add(medicines[i].name);
    }
  }

  void addItemToList() {
    setState(() {
      add_item.insert(add_item.length, item);
      add_quantity.insert(add_quantity.length, quantity);
    });
  }

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar section
      appBar: AppBar(
        title: const Text('ADD PRESCRIPTION',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),

      backgroundColor: Colors.blue[900],

      //body section
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fonts/images/regular_user_back.jpg"),
                fit: BoxFit.cover),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff232526), Color(0xff414345)]),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Colors.black54,
                // gradient: LinearGradient(
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //     colors: Colors.black54,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Medicine',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          //const SizedBox(width: 15.0),

                          const Text(
                            'Qty',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ), //******************/
                          //const SizedBox(width: 15.0),

                          //const SizedBox(height: 100.0),

                          ElevatedButton(
                            onPressed: () {
                              //setupItemsList();
                              addItemToList();
                            },
                            child: const Icon(Icons.add, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(8),
                              primary: Colors.purple, // <-- Button color
                              onPrimary: Colors.yellow, // <-- Splash color
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 35.0),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.purple,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      item = newValue!;
                                    });
                                  },
                                  value: item,
                                  items:
                                      items_list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                            SizedBox(width: 15.0),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: DropdownButton<int>(
                                  dropdownColor: Colors.purple.shade500,
                                  onChanged: (int? secValue) {
                                    //secValue is a user variable
                                    setState(() {
                                      quantity = secValue!;
                                    });
                                  },
                                  value: quantity,
                                  items:
                                      quantity_list.map<DropdownMenuItem<int>>(
                                    (int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          '$value',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Text(
                        "--Add your Medicine Here--",
                        style: TextStyle(color: Colors.white),
                      ),

                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: add_item.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              margin: const EdgeInsets.all(3),
                              color: quantity_list[index] > 3
                                  ? Colors.purple[500]
                                  : quantity_list[index] == 1
                                      ? Colors.purple[200]
                                      : Colors.purple[200],
                              child: ListTile(
                                title: Text(
                                  '${add_item[index]}               ${add_quantity[index]}  Each',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    SnackBar snackBar = SnackBar(
                                      content: Text(
                                        "Medicine Removed :  ${add_item[index]} (${add_quantity[index]})",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.blueGrey,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    setState(() {
                                      add_item.removeAt(index);
                                      add_quantity.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            onPressed: _selectTime,
                            color: Colors.purple,
                            elevation: 7.0,
                            child: const Text(
                              'Select Time',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 0),
                          RaisedButton.icon(
                            color: Colors.purple,
                            elevation: 7.0,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context, newDays),
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Days',
                              style: TextStyle(color: Colors.white),
                            ),
                            //color: Colors.purple,
                          ),
                          Column(
                            children: [
                              Text(
                                ' Time: ${_time.format(context)}',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                ' Days: ${numOfDays}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 15.0),

                      //slide button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Remind Me With Alarm',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 15.0),
                          Center(
                            child: FlutterSwitch(
                              width: 60.0,
                              height: 28.0,
                              activeColor: Colors.purple,
                              inactiveColor: Colors.grey.shade500,
                              valueFontSize: 12.0,
                              toggleSize: 30.0,
                              value: status,
                              borderRadius: 30.0,
                              padding: 6.0,
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {
                                  status = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10.0), //space between two rows

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton.icon(
                            onPressed: () async {
                              // ignore: non_constant_identifier_names
                              List<Medicine> medicine_list = [];
                              for (int i = 0; i < add_item.length; i++) {
                                //medicine_list.add(Medicine.twoArg(name: add_item[i], quantity: add_quantity[i]));
                                medicine_list.add(Medicine(
                                    name: add_item[i],
                                    quantity: add_quantity[i]));
                              }
                              for (int i = 0; i < medicine_list.length; i++) {
                                print(medicine_list[i].name);
                              }

                              List<Prescription> prescription_list = [];
                              String selected_time = _time.format(context);
                              //numOfDays = int.parse(newDays);

                              print(selected_time);
                              // prescription_list.add(Prescription(medicine: medicine_list, time: selected_time));
                              Prescription pr = Prescription(
                                medicines: medicine_list,
                                time: selected_time,
                                isAlarmOn: status,
                                numOfDays: numOfDays,
                                date: DateTime.now().toString(),
                              );
                              // Prescriptiona pre = Prescriptiona(time:"ddddd",isAlarmOn: true);
                              //print(pr.time);
                              pr = await AppDatabase.instance
                                  .addPrescription(pr);
                              var date = DateTime.now();

                              if (pr.isAlarmOn) {
                                for (int i = 0; i < pr.numOfDays; i++) {
                                  ADDING_ALARM(_time, date.year, date.month,
                                      date.day, pr.id);
                                  date = date.add(const Duration(days: 1));
                                }
                              }

                              // Navigator.pushReplacementNamed(context, '/view_prescription');
                              Get.off(() => ViewPrescriptions());
                            },
                            icon: const Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.purple,
                            elevation: 7.0,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context, String newDays) {
  return AlertDialog(
    title: const Text('Enter Number Of Days For this Prescription'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FormBuilderTextField(
          name: 'medi_name_txt', //need to add database
          keyboardType: TextInputType.number,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),

          onChanged: (newText) {
            newDays = newText!;
            // print("This is newDays);
          },

          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.purple,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange,
                width: 2,
              ),
            ),
            prefixIcon: Icon(
              Icons.date_range,
              color: Colors.purple,
            ),
            labelText: "Days",
            hintText: "Enter No:Days",
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
    actions: <Widget>[
      RaisedButton.icon(
        onPressed: () {
          numOfDays = int.parse(newDays);
          Navigator.of(context).pop();
          print("numOfDays $numOfDays");
        },
        textColor: Theme.of(context).primaryColor,
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.purple.shade500,
        elevation: 7.0,
      ),
    ],
  );
}
