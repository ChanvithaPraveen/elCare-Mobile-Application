// import 'package:alarm_manager/db/medi_database.dart';
// import 'package:alarm_manager/services/MediData.dart';
// import 'package:alarm_manager/services/Prescription.dart';
// import 'package:el_care_piltimer/services/PrescriptionB.dart';
//import 'package:flutter/cupertino.dart';
import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/services/Prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';


class ViewPrescriptions extends StatefulWidget {
  const ViewPrescriptions({Key? key}) : super(key: key);

  @override
  _ViewPrescriptionsState createState() => _ViewPrescriptionsState();
}

class _ViewPrescriptionsState extends State<ViewPrescriptions> {
  late List<Prescription> prescriptions = [];
  bool status = false;
  //late List<Medicine> medicine = [];  //mama damme meeka
  bool isLoading = false;
  //late List<MediData> pq = [];

  @override
  void initState() {
    super.initState();
    //NotesDatabase.instance.delete(1);

    refreshPrescription();
  }

  Future refreshPrescription() async {
    setState(() => isLoading = true);
    WidgetsFlutterBinding.ensureInitialized();
    this.prescriptions = await AppDatabase.instance.readAllPrescriptions();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:const Text('VIEW PRESCRIPTIONS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),

      backgroundColor: Colors.grey[850],

      body: SafeArea(
        child: Container(

          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fonts/images/regular_user_back.jpg"),
              fit: BoxFit.cover),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff232526), Color(0xff414345)]),
        ),

          child: ListView.builder(                //prescription listview
            padding: const EdgeInsets.all(8),
            itemCount: prescriptions.length,
            itemBuilder: (BuildContext context, int index) {

              return Container(
                height: 500,
                margin: const EdgeInsets.all(8),
                color: Colors.black54,

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(

                    children: [
                      const SizedBox(height: 10.0),

                      Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            //'$name',
                            'Take Medicine At: ${prescriptions[index].time}',
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        //color: Colors.purple.shade600,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.purple.shade900,
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(4),
                          itemCount: prescriptions[index].medicines!.length,
                          itemBuilder: (BuildContext context, int index2) {
                            return Container(
                              height: 50,
                              margin: const EdgeInsets.all(4),
                              color: Colors.grey.shade500,

                              child: ListTile(
                                title: Text(
                                  '${prescriptions[index].medicines![index2].name}   ->   ${prescriptions[index].medicines![index2].quantity}',//
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ),
                            );

                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlutterSwitch(
                            width: 140.0,
                            height: 40.0,
                            activeColor: Colors.purple.shade900,
                            inactiveColor: Colors.grey.shade500,
                            activeText: "Alarm ON",
                            inactiveText: "Alarm OFF",
                            valueFontSize: 20.0,
                            toggleSize: 20.0,
                            value: prescriptions[index].isAlarmOn,
                            borderRadius: 30.0,
                            padding: 8,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                                prescriptions[index] = prescriptions[index].copy(isAlarmOn: status);
                                AppDatabase.instance.updatePrescription(prescriptions[index]);

                              });
                            },
                          ),

                          RaisedButton.icon(
                            onPressed: () async {
                              SnackBar snackBar = const SnackBar(
                                content: Text("Prescription Removed",
                                  style: TextStyle(color: Colors.white),),
                                backgroundColor: Colors.blueGrey,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              int? id = prescriptions[index].id;
                              int result=await AppDatabase.instance.deletePrescription(id!);
                              prescriptions.removeAt(index);
                              print(result);
                              setState((){

                              });
                            },
                            color: Colors.purple.shade900,
                            icon: const Icon(Icons.delete, color: Colors.white,),
                            label: const Text('Delete', style: TextStyle(
                              color: Colors.white,
                            )),

                          ),
                        ],
                      ),

                    ],),
                ),
              );

            },
          ),
        ),
      ),
    );


  }
}



// ElevatedButton(
//               onPressed: () async {

//                // WidgetsFlutterBinding.ensureInitialized();
//                 // await NotesDatabase.instance.addPrescription(pre);

//               // var pr = await AppDatabase.instance.readAllPrescriptions();
//                // pp = await AppDatabase.instance.readAllPrescriptions();
//                 //var pm = await AppDatabase.instance.readAllMedicine();
//                 //print("medicine list size is ${pm.length}");
//                // pq = await NotesDatabase.instance.readAllNotes();
//                 //print("size is ${pp.length}");
//                // print("size is ${p.time}");
//                // print(pr.medicines![0]);
//                 for(int i=0;i<prescriptions.length;i++){
//                   print(prescriptions[i].toString());
//                 }

//                // print("size is ${p.time}");
//               },
//               child: Text("Show prescriptions"),
//           )