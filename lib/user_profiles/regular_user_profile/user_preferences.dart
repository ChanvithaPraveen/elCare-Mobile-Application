import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_input.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/User_Personal_Page/user_personal_details_firebase.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/settings_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:clock_app/User_Profile/settings_class.dart';
class PreferencesService {
  //

  // Future saveSettings(Settings settings) async {
  //   final preferences = await SharedPreferences.getInstance();
  //   await preferences.setString('name', settings.name);
  //   await preferences.setString('docemail', settings.hospitalName);
  //   await preferences.setString('email', settings.email);
  //   await preferences.setString('password', settings.password);
  //   await preferences.setString('additionalInfo', settings.additionalInfo);

  //   //updateFirebase();

  // }



  Future saveSettings(Settings settings) async {
    sharedPrefInit();
    putString('name', settings.name);
    putString('docemail', settings.hospitalName);
    putString('email', settings.email);
    putString('password', settings.password);
    putString('additionalInfo', settings.additionalInfo);

    //updateFirebase();

  }




  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final name = (preferences.getString('name') ?? '');
    final hospitalName = (preferences.getString('docemail') ?? '');
    final email = (preferences.getString('email') ?? '');
    final password = (preferences.getString('password') ?? '');
    final additionalInfo = (preferences.getString('additionalInfo') ?? '');
    //

    return Settings(name, hospitalName, email,  password, additionalInfo);
  }
}
