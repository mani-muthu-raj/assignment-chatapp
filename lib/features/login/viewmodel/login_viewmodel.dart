import 'package:flutter/material.dart';
import '../../../core/consts.dart';
import '../../chat/view/chat_list_screen.dart';
import '../service/login_service.dart';

class LoginViewModel extends ChangeNotifier {
  bool isPasswordVisible = true;
  final emailController = TextEditingController(text: 'swaroop.vass@gmail.com');
  final passwordController = TextEditingController(text: '@Tyrion99');

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  final LoginService _service = LoginService();
  bool isLoading = false;

  Future<void> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // 1. Validate input
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your email')));
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      // 2. Call login service
      final result = await _service.login(email: email, password: password);

      // 3. Validate result
      token = result['data']?['token'];
      final user = result['data']?['user'];

      if (token == "" || user == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed: Invalid credentials')),
          );
        }
        return;
      }

      userId = user['_id'] ?? '';
      userName = user['name'] ?? '';

      // 4. Navigate to ChatListScreen
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ChatListScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
