import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/user_role.dart';
import '../viewmodel/welcome_viewmodel.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<WelcomeViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login As",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Customer Button
              GestureDetector(
                onTap: () {
                  vm.selectRole(UserRole.customer);
                  vm.navigateToLogin(context);
                },
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.shopping_bag, size: 48, color: Colors.black),
                      SizedBox(height: 10),
                      Text("Customer Login", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Vendor Button
              GestureDetector(
                onTap: () {
                  vm.selectRole(UserRole.vendor);
                  vm.navigateToLogin(context);
                },
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.storefront, size: 48, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        "Vendor Login",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
