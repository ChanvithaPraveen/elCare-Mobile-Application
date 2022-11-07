// import 'package:clock_app/User_Profile/constants/pages.dart';
// import 'package:clock_app/User_Profile/constants/enums.dart';
// import 'package:clock_app/User_Profile/models/menu_info.dart';
import 'package:elcare_application/alarm_and_pill/services/MedicalFirebase.dart';
import 'package:elcare_application/doctor_interface/screens/pill_timer_info.dart';
import 'package:elcare_application/emergency_caller/emergency_caller.dart';
import 'package:elcare_application/sleep_tracker/sleep_tracker_charts.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/User_Personal_Page/user_personal_details.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/constants/enums.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/constants/pages.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/models/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:clock_app/User_Profile/User_Personal_Page/user_personal_details.dart';

class User_Profile_Page extends StatefulWidget {
  @override
  _User_Profile_PageState createState() => _User_Profile_PageState();
}

class _User_Profile_PageState extends State<User_Profile_Page> {
  @override
  Widget build(BuildContext context) {
    return
// [Color(0xFF6448FE), Color(0xFF5FC6FF)];
// [Color(0xFFFE6197), Color(0xFFFFB463)];
// [Color(0xFF61A3FE), Color(0xFF63FFD5)];
// [Color(0xFFFFA738), Color(0xFFFFE130)];
// [Color(0xFFFF5DCD), Color(0xFFFF8484)];

        ChangeNotifierProvider<MenuInfo>(
      create: (context) =>
          MenuInfo(MenuType.Personal, imageSource: '', title: ''),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EmergencyCaller()));
          },
          child: const Icon(Icons.call),
          backgroundColor: Colors.redAccent,
        ),
        backgroundColor: Color(0xFF2D2F41),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/fonts/images/regular_user_back.jpg"),
                fit: BoxFit.cover),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff232526), Color(0xff414345)]),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(width: 20,),
                    Icon(
                      Icons.add_chart,
                      size: 50,
                      color: Colors.white70,
                    ),
                    Text(
                      " User Profile",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: menuItems
                    .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                    .toList(),
              ),
              Expanded(
                child: Consumer<MenuInfo>(
                  builder:
                      (BuildContext context, MenuInfo value, Widget? child) {
                    if (value.menuType == MenuType.Personal)
                      // return Profile_View();
                      return UserProfilePage(); // return Profile_View();
                    // return Center(child: Container(padding:EdgeInsets.symmetric(horizontal:110, vertical: 190,), color: Colors.amberAccent, child: Text("One",style: TextStyle(color: Colors.white70,fontSize: 25),),));
                    else if (value.menuType == MenuType.Medical)
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF6448FE),
                                    Color(0xFF5FC6FF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 70),
                                onPressed: () {
                                  Get.to(SleepTrackerCharts());
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_alarm_sharp,
                                            size: 40,
                                            color: Colors.white70,
                                          ),
                                          Text(
                                            "  Sleep Details",
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ],
                                ),
                              ),
                              // height: 100.0,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFE6197),
                                    Color(0xFFFFB463)
                                  ],
                                  // colors: [Color(0xFF6448FE), Color(0xFF5FC6FF)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 70),
                                onPressed: () async {
                                  print("hello");
                                  MedicalFirebase.addMedicalDataToFirebase();
                                  var list = await MedicalFirebase
                                      .getMedicalInfoFromFirebase("email");


for(int i = 0; i<list.length; i++){
  print(list[i].date);
}









                                  print("length " + "list.length");



                                  Get.to(()=>PillTimerInfo(eachPatient: null,));
                                }, ////////////////////////////////////////////////////////
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.align_horizontal_left_rounded,
                                            size: 30,
                                            color: Colors.white70,
                                          ),
                                          Text(
                                            "  Pill Time details",
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ],
                                ),
                              ),
                              // height: 100.0,
                            ),
                          ],
                        ),
                      );
                    else
                      return Center(
                          child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 200,
                        ),
                        color: Colors.amber,
                        child: Text(
                          "Three",
                          style: TextStyle(color: Colors.white70, fontSize: 25),
                        ),
                      ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return FlatButton(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     // colors: [Color(0xFFFE6197) , Color(0xFF61A3FE)],
          //     // colors: [Color(0xFFFE6197) , Color(0xFF1E6197)],
          //     // colors: [Color(0xFFCE6197) , Color(0xFF1E6197)],
          //     colors: [Color(0xFFFE6197), Color(0xFFFFB463)],
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //   ),
          //   borderRadius: BorderRadius.all(Radius.circular(14.0)),
          // ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32))),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50),
          color: currentMenuInfo.menuType == value.menuType
              // ? Color(0xFF242634)
              // ? Color(0xFF444974)
              // ? Color(0xFF748EF6)
              ? Color(0xFFC279FB) //
              // ? Color(0xFFEA74AB)
              // ? Color(0xFFFE6197)
              // : Colors.transparent,
              : Colors.transparent,
          onPressed: () {
            var menuInfo = Provider.of<MenuInfo>(context, listen: false);
            menuInfo.updateMenu(currentMenuInfo);
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                currentMenuInfo.imageSource,
                scale: 1.3,
              ),
              SizedBox(height: 6),
              Text(
                currentMenuInfo.title,
                style: TextStyle(
                    // fontFamily: 'avenir',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
