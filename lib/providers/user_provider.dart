import 'package:evently/models/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void userUpdate(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }

  void logout() {
    currentUser = null;
    notifyListeners();
  }
}
