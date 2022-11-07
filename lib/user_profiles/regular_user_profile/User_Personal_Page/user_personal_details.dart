import 'package:elcare_application/controllers/login_controller.dart';
import 'package:elcare_application/emergency_caller/emergency_caller.dart';
import 'package:elcare_application/login_screen.dart';
import 'package:elcare_application/shared_pref/shared_pref_input.dart';
import 'package:elcare_application/shared_pref/shared_pref_reset.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/User_Personal_Page/user_personal_details_firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../settings_class.dart';
import '../user_preferences.dart';

// import 'package:clock_app/User_Profile/user_preferences.dart';
// import 'package:clock_app/User_Profile/settings_class.dart';

class UserProfilePage extends StatefulWidget {
  // ProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isObscure = true;

  final _nameController = TextEditingController();
  final _doctorEmailController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  //
  final _preferencesService = PreferencesService();

//saving data function
  void _saveSettings() {
    final newSettings = Settings(
        _nameController.text,
        _doctorEmailController.text,
        _emailController.text,
        _passwordController.text,
        _additionalInfoController.text);
    //
    _preferencesService.saveSettings(newSettings);
    print(_doctorEmailController.text);
  }

//retrieving saved data function
  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    //
    setState(() {
      _nameController.text = settings.name;
      _doctorEmailController.text = settings.hospitalName;
      _emailController.text = settings.email;
      _passwordController.text = settings.password;
      _additionalInfoController.text = settings.additionalInfo;
    });
  }

  void initState() {
    super.initState();

    _populateFields();
    print("Email: " + _emailController.text);
  }

  //
  String name = '';
  String hospitalName = '';
  String email = '';
  String password = '';
  String additionalNote = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.all(8.0),
      
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: <Color>[
          //       Color(0xFF2D2F41),
          //       Color(0xFF2D2F41),
          //     ]),
          color: Colors.black54
        ),
        child: ListView(padding: const EdgeInsets.all(10.0), children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  "Personal details",
                  style: TextStyle(
                    //fontFamily: "Avenir",
                    fontSize: 30,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: _nameController,
            //
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
            ),
            keyboardType: TextInputType.name,
            //
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: _doctorEmailController,
            //
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Doctor's Email",
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
            ),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: _emailController,
            enabled: false,
            //
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "My Email",
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 14.0,
          ),
          TextField(
            controller: _passwordController,
            //
            obscureText: _isObscure,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              labelText: "Password",
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                  )),
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            height: 150.0,
            child: TextField(
              controller: _additionalInfoController,

              //
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Additional Notes",
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                    )),
              ),
              keyboardType: TextInputType.name,
              maxLines: 10,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.teal[500],
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: TextButton(
                      onPressed: () {
                        _saveSettings();
                        updateFirebase();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(width: 10),
                Container(
                  width: 110,
                  decoration: BoxDecoration(
                      color: Colors.red[800],
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: TextButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text(
                                        'Are you sure that you want to Log out?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.red[800]),
                                  child: const Text(
                                    'Log Out',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    reset();
                                    putString('logged', 'false');
                                    Provider.of<LoginController>(context,
                                            listen: false)
                                        .logout();
                                    Get.off(() => LoginScreen());
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(width: 60,)
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ]),
      ),
    );
  }
}
