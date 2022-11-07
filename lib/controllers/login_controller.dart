import 'package:elcare_application/model/user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController with ChangeNotifier{
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  googleLogin() async{
    this.googleSignInAccount =  await _googleSignIn.signIn();

    this.userDetails = new UserDetails(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    notifyListeners();
  }

  logout() async{
    this.googleSignInAccount = await _googleSignIn.signOut();
    userDetails = null;
    notifyListeners();
  }
}