import 'package:flutter/material.dart';

// Pages
import 'package:lihat_lukis/pages/login_page.dart';
import 'package:lihat_lukis/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration:
              const Duration(milliseconds: 300), // Duration of the transition
          transitionBuilder: (Widget child, Animation<double> animation) {
            // You can use FadeTransition or SlideTransition for the animation
            return FadeTransition(opacity: animation, child: child);
          },
          child: showLoginPage
              ? LoginPage(onTap: togglePages)
              : RegisterPage(onTap: togglePages),
        ),
      ),
    );
  }
}
