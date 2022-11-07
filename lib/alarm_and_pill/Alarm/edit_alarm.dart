import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Alarm_Data/alarm_info.dart';
import 'alarm_page.dart';


class EditAlarm extends StatefulWidget {


  @override
  _EditAlarmState createState() => _EditAlarmState();
}
class _EditAlarmState extends State<EditAlarm> {

  TextEditingController _textEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    Future<void> _openTimePicker(BuildContext context) async{
      final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (t != null){
        setState(() {
          SelectedTimeInDateTimeFormat = t;
          SelectedTimeInStringFormat = t.format(context);
        });
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Container(
        //margin: EdgeInsets.symmetric(horizontal: 20.0 , vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:<Widget> [
              Column(
                children: [
                  SizedBox(height: 40.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Edit Alarm",
                        style: TextStyle(
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 40, 10, 20),
                        child: Text(
                          "Purpose",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                      cursorColor: Colors.white,
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "  Type the purpose",
                        hintStyle: TextStyle(
                          color: Colors.white30,
                        ),
                        border: InputBorder.none,
                        fillColor: Colors.black38,
                        filled: true,
                      ),
                      keyboardType: TextInputType.text,
                      maxLength: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 20, 10, 20),
                        child: Text(
                          "Set alarm time",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 40.0),
                      Container(
                        height: 46,
                        width:  150,
                        child: FlatButton(                                              ///////////////////////////////////////////////////////
                          /////////////////////////// Yes pick  //////////////////
                          onPressed: (){

                            final time=_openTimePicker(context);
                            print(SelectedTimeInDateTimeFormat);
                            print(SelectedTimeInStringFormat);


                          },                                             ////////////////////////////////////////////////////////
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_alarms,
                                      size: 25,
                                      color: Colors.white24,
                                    ),
                                    Text(
                                      "Pick Time",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: Text(
                          "Vibrate",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Checkbox(
                            value: Vibrateok,   // //////////////////checkBoxValue is a external boolean variable
                            onChanged: (value){
                              setState(() {
                                Vibrateok=!Vibrateok;
                              });
                            },
                          )
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: Text(
                          "Select days",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),

                  //For 7 days
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width:  50,
                            child: FlatButton(                                              ///////////////////////////////////////////////////////
                              /////////////////////////// Yes pick  //////////////////
                              onPressed: (){
                                if(Weekdays[0]==false) {Weekdays[0]=true; WeekdayButtonColor[0] = EnableColor; {setState(() {});};}
                                else {Weekdays[0]=false; WeekdayButtonColor[0] = DisableColor; {setState(() {});};}

                                print(Weekdays[0]);
                              },                                             ////////////////////////////////////////////////////////
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Mo",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ],
                              ),
                            ),
                            // height: 100.0,
                            decoration: BoxDecoration(
                              color: WeekdayButtonColor[0],
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        ],

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width:  50,
                            child: FlatButton(                                              ///////////////////////////////////////////////////////
                              /////////////////////////// Yes pick  //////////////////
                              onPressed: (){
                                if(Weekdays[1]==false) {Weekdays[1]=true; WeekdayButtonColor[1] = EnableColor; {setState(() {});};}
                                else {Weekdays[1]=false; WeekdayButtonColor[1] = DisableColor; {setState(() {});};}

                                print(Weekdays[1]);
                              },                                             ////////////////////////////////////////////////////////
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Tu",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ],
                              ),
                            ),
                            // height: 100.0,
                            decoration: BoxDecoration(
                              color: WeekdayButtonColor[1],
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width:  50,
                            child: FlatButton(                                              ///////////////////////////////////////////////////////
                              /////////////////////////// Yes pick  //////////////////
                              onPressed: (){
                                if(Weekdays[2]==false) {Weekdays[2]=true; WeekdayButtonColor[2] = EnableColor; {setState(() {});};}
                                else {Weekdays[2]=false; WeekdayButtonColor[2] = DisableColor; {setState(() {});};}

                                print(Weekdays[2]);
                              },                                             ////////////////////////////////////////////////////////
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "We",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ],
                              ),
                            ),
                            // height: 100.0,
                            decoration: BoxDecoration(
                              color: WeekdayButtonColor[2],
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width:  50,
                            child: FlatButton(                                              ///////////////////////////////////////////////////////
                              /////////////////////////// Yes pick  //////////////////
                              onPressed: (){
                                if(Weekdays[3]==false) {Weekdays[3]=true; WeekdayButtonColor[3] = EnableColor; {setState(() {});};}
                                else {Weekdays[3]=false; WeekdayButtonColor[3] = DisableColor; {setState(() {});};}

                                print(Weekdays[3]);
                              },                                             ////////////////////////////////////////////////////////
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Th",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ],
                              ),
                            ),
                            // height: 100.0,
                            decoration: BoxDecoration(
                              color: WeekdayButtonColor[3],
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width:  50,
                            child: FlatButton(                                              ///////////////////////////////////////////////////////
                              /////////////////////////// Yes pick  //////////////////
                              onPressed: (){
                                if(Weekdays[4]==false) {Weekdays[4]=true; WeekdayButtonColor[4] = EnableColor; {setState(() {});};}
                                else {Weekdays[4]=false; WeekdayButtonColor[4] = DisableColor; {setState(() {});};}

                                print(Weekdays[4]);
                              },                                             ////////////////////////////////////////////////////////
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Fr",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ],
                              ),
                            ),
                            // height: 100.0,
                            decoration: BoxDecoration(
                              color: WeekdayButtonColor[4],
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width:  50,
                            child: FlatButton(                                              ///////////////////////////////////////////////////////
                              /////////////////////////// Yes pick  //////////////////
                              onPressed: (){
                                if(Weekdays[5]==false) {Weekdays[5]=true; WeekdayButtonColor[5] = EnableColor; {setState(() {});};}
                                else {Weekdays[5]=false; WeekdayButtonColor[5] = DisableColor; {setState(() {});};}

                                print(Weekdays[5]);
                              },                                             ////////////////////////////////////////////////////////
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sa",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ],
                              ),
                            ),
                            // height: 100.0,
                            decoration: BoxDecoration(
                              color: WeekdayButtonColor[5],
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width:  50,
                            child: FlatButton(                                              ///////////////////////////////////////////////////////
                              /////////////////////////// Yes pick  //////////////////
                              onPressed: (){
                                if(Weekdays[6]==false) {Weekdays[6]=true; WeekdayButtonColor[6] = EnableColor; {setState(() {});};}
                                else {Weekdays[6]=false; WeekdayButtonColor[6] = DisableColor; {setState(() {});};}

                                print(Weekdays[6]);
                              },                                             ////////////////////////////////////////////////////////
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Su",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                  ),
                                ],
                              ),
                            ),
                            // height: 100.0,
                            decoration: BoxDecoration(
                              color: WeekdayButtonColor[6],
                              borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 46,
                    width:  150,
                    child: FlatButton(                                              ///////////////////////////////////////////////////////
                      /////////////////////////// Yes pick  //////////////////
                      onPressed: (){
                        text=_textEditingController.text;
                        if(text=='') {text = 'Alarm $ListIndex';}
                        if(SelectedTimeInStringFormat =="")
                        {
                          SelectedTimeInDateTimeFormat = TimeOfDay.now();
                          SelectedTimeInStringFormat = TimeOfDay.now().format(context);
                        }




                        if(Append==false)
                        {
                          AlarmInfo Temp = AlarmInfo(SelectedTimeInDateTimeFormat, SelectedTimeInStringFormat , DateTime.now() , text , true, ListIndex , Weekdays , WeekdayButtonColor , Vibrateok , false,0);

                          setState(() {
                            for(int i =0;i<allalarms.length;i++)
                            {
                              if(ListIndex==allalarms[i].AlarmNumber)
                              {
                                allalarms[i]=Temp;
                              }
                            }
                            for(int i =0;i<alarms.length;i++)
                            {
                              if(ListIndex==alarms[i].AlarmNumber)
                              {
                                alarms[i]=Temp;
                              }
                            }

                            // Navigator.pop(context);
                            // Navigator.pushNamed(context, '/alarm_page');
Get.off(()=>AlarmPage());
                            // ListIndex = -1;
                          });
                        }
                        else
                        {
                          AlarmInfo Temp = AlarmInfo(SelectedTimeInDateTimeFormat, SelectedTimeInStringFormat , DateTime.now() , text , true, ListIndex , Weekdays , WeekdayButtonColor , Vibrateok , false,0);

                          setState(() {
                            allalarms.add(Temp);
                            alarms.add(Temp);

                            // Navigator.pop(context);
                            // Navigator.pushNamed(context, '/alarm_page');
Get.off(()=>AlarmPage());
                            ListIndex = 0;
                          });
                        }
                      },                                             ////////////////////////////////////////////////////////
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_alarm_outlined,
                                  size: 25,
                                  color: Colors.white70,
                                ),
                                Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],
                      ),
                    ),
                    // height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                  ),
                ],

              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 46,
                    width:  150,
                    child: FlatButton(                                              ///////////////////////////////////////////////////////
                      /////////////////////////// Yes pick  //////////////////
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
                                  size: 25,
                                  color: Colors.white70,
                                ),
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
