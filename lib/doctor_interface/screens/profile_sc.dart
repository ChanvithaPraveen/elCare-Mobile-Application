import 'package:elcare_application/doctor_interface/classes/settings_class.dart';
import 'package:elcare_application/doctor_interface/user_data/user_preferences.dart';
import 'package:elcare_application/login_screen.dart';
import 'package:elcare_application/regular_user_menu.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isObscure = true;

  final _nameController = TextEditingController();
  final _hospital_nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  //
  final _preferencesService = PreferencesService();

//saving data function
  void _saveSettings() {
    final newSettings = Settings(
      _nameController.text,
      _hospital_nameController.text,
      _emailController.text,
      _passwordController.text,
      _additionalInfoController.text
    );
    //
    _preferencesService.saveSettings(newSettings);
  }

//retrieving saved data function
  void _populateFields() async {
    final settings = await _preferencesService.getSettings();
    //
    setState(() {
      _nameController.text = settings.name;
      _hospital_nameController.text = settings.hospitalName;
      _emailController.text = settings.email;
      _passwordController.text = settings.password;
      _additionalInfoController.text = settings.additionalInfo;
    });
  }

  void initState() {
    super.initState();

    _populateFields();
  }

  //
  String name = '';
  String hospitalName = '';
  String email = '';
  String password = '';
  String additionalNote = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5.0,
        backgroundColor: Colors.blue[900],
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
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
        child: ListView(padding: const EdgeInsets.all(10.0), children: [
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: _nameController,
            //
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
              labelText: "Name ",
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
            controller: _hospital_nameController,
            //
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
              labelText: "Email",
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
            //
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
              labelText: "Hospital Name ",
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
              focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              labelText: "Password ",
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
                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orange,
                                      width: 2,
                                    ),
                                  ),
                labelText: "Additional Note ",
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
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    
                    child: TextButton(
                      onPressed: _saveSettings, 
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold), )),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                   Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    
                    child: TextButton(
                      onPressed: (){
                        sharedPrefInit();
                        putString("logged", "false");
                        Get.off(()=>LoginScreen());
                      }, 
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold), )),
                  ),
                ],
              ),
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
