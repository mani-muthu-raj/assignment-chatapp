import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/consts.dart';
import '../viewmodel/login_viewmodel.dart';
import '../../register/widget/my_password_field.dart';
import '../../register/widget/my_text_button.dart';
import '../../register/widget/my_text_field.dart';
import '../../register/view/register_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Image(
                      image: AssetImage('assets/images/team_illustration.png'),
                    ),
                  ),
                  Text("Welcome back.", style: kHeadline),
                  const SizedBox(height: 10),
                  Text("You've been missed!", style: kBodyText2),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: vm.emailController,
                    hintText: 'Email',
                    inputType: TextInputType.text,
                  ),
                  MyPasswordField(
                    controller: vm.passwordController,
                    isPasswordVisible: vm.isPasswordVisible,
                    onTap: vm.togglePasswordVisibility,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: kBodyTextSmall),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: kBodyText.copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  MyTextButton(
                    buttonName: 'Sign In',
                    onTap: () {
                      vm.login(context);
                    },
                    bgColor: Colors.black,
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
