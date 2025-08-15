import 'package:assignment_flutter/features/login/view/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/welcome/view/welcome_screen.dart';
import 'features/welcome/viewmodel/welcome_viewmodel.dart';
import 'features/message/view/message_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => WelcomeViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => const WelcomeScreen(),
        '/login': (_) => LoginScreen(),
        '/messages': (_) => const MessageScreen(),
      },
    );
  }
}
