import 'package:flutter/material.dart';

import '../model/register_model.dart';

class RegisterViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void register() {
    final model = RegisterModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    debugPrint("Registering user: ${model.name}, ${model.email}");
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
