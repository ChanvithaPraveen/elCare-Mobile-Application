import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elcare_application/alarm_and_pill/services/PIllTakeInfo.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
import 'package:firebase_core/firebase_core.dart';

add_pill_take_info(List<PillTakeInfo> list)async{
  print("Hello");
  sharedPrefInit();
  String email = await getString("email");
  String password = await getString("password");
  String docemail = await getString("docemail");
  String name = await getString("name");
  
for(int i=0; i<list.length;i++){
  await FirebaseFirestore
    .instance
    .collection('users')
    .doc('$email')
    .collection(
        "user_orders")
    .add(list[i].toJson());
}



  // await FirebaseFirestore
  //   .instance
  //   .collection('users')
  //   .doc('ghjh@mm.com')
  //   .collection(
  //       "user_orders")
  //   .add();
  
}