
import 'package:elcare_application/doctor_interface/classes/settings_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  //

  Future saveSettings(Settings settings) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('name', settings.name);
    await preferences.setString('hospital name', settings.hospitalName);
    await preferences.setString('email', settings.email);
    await preferences.setString('password', settings.password);
    await preferences.setString('additionalInfo', settings.additionalInfo);
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final name = (preferences.getString('name') ?? '');
    final hospitalName = (preferences.getString('hospital name') ?? '');
    final email = (preferences.getString('email') ?? '');
    final password = (preferences.getString('password') ?? '');
    final additionalInfo = (preferences.getString('additionalInfo') ?? '');
    //

    return Settings(name, email, hospitalName, password, additionalInfo);
  }
}