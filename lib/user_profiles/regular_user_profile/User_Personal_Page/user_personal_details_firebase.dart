import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/User_Personal_Page/pill_take_info_firebase.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/user_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

updateFirebase() async {
  print("firebase awa");
  sharedPrefInit();
  String email = await getString("email");
  String password = await getString("password");
  String docemail = await getString("docemail");
  String name = await getString("name");
  print(name);
  String additionalInfo = await getString("additionalInfo");
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // add_pill_take_info();
  return users
      .doc(email)
      .update({
        'name': name, // John Doe
        'password': password, // Stokes and Sons
        'docemail': docemail,
        'additionalInfo': additionalInfo
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));

      // add_pill_take_info();
}
