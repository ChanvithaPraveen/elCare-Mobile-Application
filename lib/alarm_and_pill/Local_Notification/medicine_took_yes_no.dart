// import 'package:alarm_manager/Alarm_Data/alarm_info.dart';
// import 'package:alarm_manager/db/medi_database.dart';
// import 'package:alarm_manager/services/PillTakeInfo.dart';
import 'package:elcare_application/alarm_and_pill/Alarm_Data/alarm_info.dart';
import 'package:elcare_application/alarm_and_pill/Alarm_Data/editable_lists.dart';
import 'package:elcare_application/alarm_and_pill/db/medi_database.dart';
import 'package:elcare_application/alarm_and_pill/services/PillTakeInfo.dart';
import 'package:flutter/material.dart';
// import 'package:alarm_manager/Alarm_Data/editable_lists.dart';


class Confirmation_MSG extends StatefulWidget {

  @override
  _Confirmation_MSGState createState() => _Confirmation_MSGState();
}
class _Confirmation_MSGState extends State<Confirmation_MSG> {



  @override
  Widget build(BuildContext context) {

    setState(() {

    });
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF2D2F41),
        body: SafeArea(
          child: Center(
            child: Container(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:30),
                  Row(
                    children: [
                      SizedBox(width: 30,),
                      Text(
                        "Did you take medicine?",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 45.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 70,
                        width:  150,
                        child: FlatButton(                                              ///////////////////////////////////////////////////////
                          /////////////////////////// Yes pick  //////////////////
                          onPressed: () async {

                            enable = 0;

                            AlarmInfo ActivatedAlarmObject = GET;
                            var today = DateTime.now();
                            String date = "${today.year}.${today.month}.${today.day}";
                            String time = "${today.hour}:${today.minute}";
                            var pillTakeInfo = PillTakeInfo(date:date, time: time, prescription_id:ActivatedAlarmObject.PrescriptionID); ///wenas kara
                            var pillTake = await AppDatabase.instance.addPillTakeInfo(pillTakeInfo);
                            print("date is${pillTake.date}");

                            //update medidata
                            var medidata = await AppDatabase.instance.readAllMediData();
                            var prescription = await AppDatabase.instance.readPrescription(ActivatedAlarmObject.PrescriptionID); //wenas kara

                            for(int i =0;i<prescription.medicines!.length;i++){
                              for(int j=0;j<medidata.length;j++){
                                if(prescription.medicines![i].name==medidata[j].name){
                                  medidata[j]= medidata[j].copy(
                                    quantity: medidata[j].quantity - prescription.medicines![i].quantity
                                  );
                                  await AppDatabase.instance.updateMediData(medidata[j]);
                                }
                              }
                            }

                            print("Alarm index is ${ActivatedAlarmObject.AlarmNumber} , He took medicine and The prescriptionId is ${ActivatedAlarmObject.PrescriptionID} }");
                            Navigator.pop(context);

                            setState(()  {


                            });

                          },                                             ////////////////////////////////////////////////////////
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.white24,
                                    ),
                                    Text(
                                      "Yes",
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20),
                              ),
                            ],
                          ),
                        ),
                        // height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        ),
                      ),

                      Container(
                        height: 70,
                        width:  150,
                        child: FlatButton(                                              ///////////////////////////////////////////////////////
                          /////////////////////////// Cancel pick  //////////////////
                          onPressed: (){

                            enable = 0;

                            setState(() {

                              AlarmInfo ActivatedAlarmObject = GET;

                              print("Alarm index is ${ActivatedAlarmObject.AlarmNumber} , He DID NOT took medicine and The prescriptionId is ${ActivatedAlarmObject.PrescriptionID} }");
                              Navigator.pop(context);
                            });

                          },                                             ////////////////////////////////////////////////////////
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      size: 30,
                                      color: Colors.white24,
                                    ),
                                    Text(
                                      "No",
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20),
                              ),
                            ],
                          ),
                        ),
                        // height: 100.0,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
