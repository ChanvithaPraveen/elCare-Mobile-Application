// import 'dart:html';

import 'package:elcare_application/controllers/login_controller.dart';
import 'package:elcare_application/doctor_user_menu.dart';
// import 'package:elcare_application/doctor_interfaces/screens/doctor_user_menu.dart';
// import 'package:elcare_application/doctor_interfaces/screens/doctor_user_menu.dart';
import 'package:elcare_application/regular_user_menu.dart';
import 'package:elcare_application/shared_pref/shared_pref_init.dart';
import 'package:elcare_application/shared_pref/shared_pref_input.dart';
import 'package:elcare_application/shared_pref/shared_pref_output.dart';
// import 'package:elcare_application/usertype_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
/////////////////Firebase

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': "wefwe", // John Doe
          'company': "Wefwef", // Stokes and Sons
          'age': 50 // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

/////////////////Firebase END
  ///
  ///
  ///
  ///
  bool _checkboxvalue = false;
  String? username;
  String? password;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  String usertype = "RegularUser";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    //addUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false, body: loginUI());
  }

  loginUI() {
    return Consumer<LoginController>(builder: (context, model, child) {
      //if already logged in
      if (model.userDetails != null) {
        return Center(
          child: loggedInUI(model),
        );
      } else {
        return loginController(context);
      }
    });
  }

  loggedInUI(LoginController model) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/fonts/images/loginback.jpg"),
            fit: BoxFit.cover),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff232526), Color(0xff414345)]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundImage:
                  Image.network(model.userDetails!.photoURL ?? "").image,
              radius: 50,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Welcome!\n ' + (model.userDetails!.displayName ?? ""),
            style: TextStyle(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Text(
            model.userDetails!.email ?? "",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () async {
              print("Button eka ebuwa");
              bool userAlreadyLogged = false;
              //if user is pre registerd
              await FirebaseFirestore.instance
                  .doc('users/${model.userDetails!.email}')
                  .get()
                  .then((onValue) {
                // onValue.exists ? print("Atha") : print("natha");
                onValue.exists
                    ? userAlreadyLogged = true
                    : userAlreadyLogged = false;
              });

              if (!userAlreadyLogged) {
                print("pora na");
                //user firebase eke na
                putString("email", "${model.userDetails!.email ?? ""}");
                putString("name", "${model.userDetails!.displayName ?? ""}");
                putString("password", "password");
                putString("logged", "true");
                print("Firebase mulata awa");
                users
                    .doc(model.userDetails!.email)
                    .set({
                      'name': model.userDetails!.displayName ?? "",
                      'password': "password",
                      'userType': usertype
                    })
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));

                if ((await getString("userType")) == "Doctor") {
                  //goto doctors screen
                  Get.off(() => DoctorMenu());
                } else {
                  Get.off(RegularUserMain());
                  //goto regular screen
                }
              } else {
                print("pora innawa");
                //user firebase eke innw
                String userTypeFromFire;
                DocumentSnapshot variable =
                    await users.doc(model.userDetails!.email).get();
                userTypeFromFire = variable['userType'];

                putString("userType", "$userTypeFromFire");
                if (userTypeFromFire == "Doctor") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegularUserMain()),
                  );
                } else {
                  Get.off(RegularUserMain());
                  //goto regular interface
                  Get.off(() => RegularUserMain);
                }
              }
              putString("logged", "true");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Goto Main Menu ',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Colors.amber[100])),
                Icon(
                  Icons.navigate_next_outlined,
                  color: Colors.amber[100],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              putString("logged", "false");
              Provider.of<LoginController>(context, listen: false).logout();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_sharp,
                  color: Colors.red[100],
                ),
                Text('Logout',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.red[100])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  loginController(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/fonts/images/loginback.jpg"),
            fit: BoxFit.cover),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff232526), Color(0xff414345)]),
      ),
      // color: Colors.purple[800],
      child: Column(children: [
        SizedBox(height: 40,),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fonts/images/logo.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ]),
        ),
        Container(
            //color: Colors.red,
            // height: 200,
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Text('I am a $usertype',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        setState(() {
                          usertype = "RegularUser";
                        });
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              usertype == "RegularUser" ? Colors.blue : null),
                      icon: Icon(Icons.supervised_user_circle_rounded,
                          color: Colors.white),
                      label: Text("Regular User",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white))),
                  SizedBox(width: 20),
                  TextButton.icon(
                      onPressed: () {
                        setState(() {
                          usertype = "Doctor";
                        });
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              usertype == "Doctor" ? Colors.blue : null),
                      icon: Icon(Icons.local_hospital_rounded,
                          color: Colors.white),
                      label: Text("Doctor",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white))),
                ],
              ),
              SizedBox(width: 20),
              TextField(
                  controller: nameController,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
                      prefixIcon: Icon(
                        Icons.manage_accounts,
                        color: Colors.lightBlue[200],
                        size: 35,
                      ),
                      
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.lightBlue[200]),
                      
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(30.0)))),
              SizedBox(
                height: 5,
              ),
              TextField(
                  controller: emailController,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                    
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.lightBlue[200],
                        size: 35,
                      ),
                      hintText: "email",
                      hintStyle: TextStyle(color: Colors.lightBlue[200]),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(30.0)))),
              SizedBox(
                height: 5,
              ),
              TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 15.0),
                      prefixIcon: Icon(
                        Icons.password,
                        color:  Colors.lightBlue[200],
                        size: 35,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.lightBlue[200]),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(30.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(30.0)))),

              SizedBox(
                height: 30,
              ),

              LoginButtons(
                  'Login / SignUp',
                  Icons.login_rounded,
                  Colors.greenAccent[500],
                  1,
                  emailController,
                  passwordController,
                  nameController,
                  users,
                  usertype),

              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              LoginButtons(
                  'Login with Gmail',
                  Icons.mail_rounded,
                  Colors.red[500],
                  0,
                  emailController,
                  passwordController,
                  nameController,
                  users,
                  usertype),
              SizedBox(height: 10),
              // LoginButtons(
              //     'Login with Facebook', Icons.facebook, Colors.blue,1),
            ]))
      ]),
    );
  }
}

class LoginButtons extends StatelessWidget {
  String? text;
  IconData? icon;
  Color? color;
  int? acc;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController nameController;
  String usertype;
  CollectionReference users;
  LoginButtons(
      this.text,
      this.icon,
      this.color,
      this.acc,
      this.emailController,
      this.passwordController,
      this.nameController,
      this.users,
      this.usertype) {}

  bool validateEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  void addUser() async {}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //google login
        if (acc == 0) {
          putString("userType", "$usertype");
          Provider.of<LoginController>(context, listen: false).googleLogin();
        } else {
          if (validateEmail(emailController.text)) {
            if (nameController.text == "" || passwordController.text == "") {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Empty input fields'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
            } else {
              bool userAlreadyLogged = false;
              //if user is pre registerd
              await FirebaseFirestore.instance
                  .doc('users/${emailController.text}')
                  .get()
                  .then((onValue) {
                // onValue.exists ? print("Atha") : print("natha");
                onValue.exists
                    ? userAlreadyLogged = true
                    : userAlreadyLogged = false;
              });
              print("user logged $userAlreadyLogged");
              print(emailController.text);
              if (userAlreadyLogged) {
                String password;
                String userTypeFromFire;
                String name;

                //////todo
                ///kalin log wechcha porak nam password harida kyl balala
                ///user data phone eke save krnw
                ///aluth porak nm firebase ekt add krl
                ///userdata phone ekt add krnw
                DocumentSnapshot variable =
                    await users.doc(emailController.text).get();
                password = variable['password'];
                print(password);

                //user enter karapu password eka kalid dapu ekath ekka harida kiyala balanawa
                if (password == passwordController.text) {
                  print("In");
                  userTypeFromFire = variable['userType'];
                  name = variable['name'];
                  print(userTypeFromFire);
                  print(name);

                  ///password, name, usertype, email shared walata save karala
                  ///adala usertype screen ekata ynna
                  sharedPrefInit();
                  putString("email", "${emailController.text}");
                  putString("name", "$name");
                  putString("password", "$password");
                  putString("userType", "$userTypeFromFire");
                  putString("logged", "true");
                  // print(await getString("email"));
                  // print(await getString("name"));
                  // print(await getString("password"));
                  // print(await getString("userType"));
                  // print(await getString("logged"));
                  if (userTypeFromFire == "Doctor") {
                    //goto doctors interface
                    Get.off(() => DoctorMenu());
                  } else {
                    //goto regular user interface

                    print("Hello");
                    Get.off(RegularUserMain());
                  }
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Wrong Username or Password'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                print("user not in");
                users
                    .doc(emailController.text)
                    .set({
                      'name': nameController.text,
                      'password': passwordController.text,
                      'userType': usertype
                    })
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));

                ///password, name, usertype, email shared walata save karala
                ///adala usertype screen ekata ynna
                sharedPrefInit();
                putString("email", "${emailController.text}");
                putString("name", "${nameController.text}");
                putString("password", "${passwordController.text}");
                putString("userType", "$usertype");
                putString("logged", "true");
                if (usertype == "Doctor") {
                  //goto doctors interface
                  Get.off(() => DoctorMenu());
                } else {
                  Get.off(RegularUserMain());
                  //goto regular user interface
                }
              }
            }
          } else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Wrong Email'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            );
          }
          // users
          //     .doc(emailController.text)
          //     .set({
          //       'name': nameController.text,
          //       'password': passwordController.text,
          //       'usertype': usertype
          //     })
          //     .then((value) => print("User Added"))
          //     .catchError((error) => print("Failed to add user: $error"));
        }
      },
      style: ElevatedButton.styleFrom(
          primary: color,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30))),
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 10),
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(
              text.toString(),
              style: TextStyle(fontFamily: 'Urbanist'),
            ),
          ]),
        ),
      ),
    );
  }
}
