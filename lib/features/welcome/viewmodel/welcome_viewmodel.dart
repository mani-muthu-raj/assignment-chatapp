import 'package:flutter/material.dart';
import '../model/user_role.dart';

class WelcomeViewModel extends ChangeNotifier {
  UserRole? selectedRole;

  void selectRole(UserRole role) {
    selectedRole = role;
    notifyListeners();
  }

  void navigateToLogin(BuildContext context) {
    if (selectedRole == null) return;

    switch (selectedRole!) {
      case UserRole.customer:
        Navigator.pushNamed(context, '/login');
        break;
      case UserRole.vendor:
        Navigator.pushNamed(context, '/login');
        break;
    }
  }
}
