import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/consts.dart';
import '../viewmodel/register_viewmodel.dart';
import '../widget/my_password_field.dart';
import '../widget/my_text_button.dart';
import '../widget/my_text_field.dart';
import '../../login/view/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<RegisterViewModel>(
            builder: (context, vm, _) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Register", style: kHeadline),
                                Text(
                                  "Create a new account to get started.",
                                  style: kBodyText2,
                                ),
                                const SizedBox(height: 50),
                                MyTextField(
                                  controller: vm.nameController,
                                  hintText: 'Name',
                                  inputType: TextInputType.name,
                                ),
                                MyTextField(
                                  controller: vm.emailController,
                                  hintText: 'Email',
                                  inputType: TextInputType.emailAddress,
                                ),
                                MyTextField(
                                  controller: vm.phoneController,
                                  hintText: 'Phone',
                                  inputType: TextInputType.phone,
                                ),
                                MyPasswordField(
                                  controller: vm.passwordController,
                                  isPasswordVisible: vm.passwordVisible,
                                  onTap: vm.togglePasswordVisibility,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: kBodyText,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                ),
                                child: Text(
                                  "Sign In",
                                  style: kBodyText.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          MyTextButton(
                            buttonName: 'Register',
                            onTap: vm.register,
                            bgColor: Colors.black,
                            textColor: Colors.white,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
