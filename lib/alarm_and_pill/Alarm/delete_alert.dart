import 'package:elcare_application/alarm_and_pill/Alarm/alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Alarm_Data/alarm_info.dart';
import '../User_Set_Alarm_Run/trigger_alarms.dart';



class Delete_alert extends StatefulWidget {


  @override
  _Delete_alertState createState() => _Delete_alertState();
}
class _Delete_alertState extends State<Delete_alert> {
  @override
  Widget build(BuildContext context) {
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
                        "Delete alarm?",
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
                          onPressed: (){

                            if(alarms.length>1)
                            {
                              for(int i =0;i<allalarms.length;i++)
                              {
                                if(ListIndex==allalarms[i].AlarmNumber)
                                {
                                  allalarms.removeAt(i);

                                }
                              }
                              for(int i =0;i<alarms.length;i++)
                              {
                                if(ListIndex==alarms[i].AlarmNumber)
                                {
                                  setState(() {
                                    alarms.removeAt(i);
                                  });
                                }
                              }
                              for(int i =0;i<alarms.length;i++)
                              {
                                if(ListIndex==alarms[i].AlarmNumber)
                                {
                                  setState(() {
                                    alarms.removeAt(i);
                                  });
                                }
                              }
                            }

                            User_set_Deactivate_Alarm(ListIndex);


                            print(allalarms.length);
                            print(alarms.length);
                            // Navigator.pop(context);
                            // Navigator.pushNamed(context, '/alarm_page');
                            Get.off(()=>AlarmPage());
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
                                      "Confirm",
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
                            // Navigator.pop(context);
                            // Navigator.pushNamed(context, '/alarm_page');
                            Get.off(()=>AlarmPage());
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
                                      "Cancel",
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
