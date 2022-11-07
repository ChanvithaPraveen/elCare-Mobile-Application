// import 'package:clock_app/User_Profile/constants/enums.dart';
import 'package:elcare_application/user_profiles/regular_user_profile/constants/enums.dart';
import 'package:flutter/foundation.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(this.menuType, {required this.title, required this.imageSource});

  updateMenu(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

//Important
    notifyListeners();
  }
}
