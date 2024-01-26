import 'package:flutter/material.dart';

//firebase
import 'package:firebase_auth/firebase_auth.dart';

//pages
import 'package:lihat_lukis/auth/login_or_register.dart';
import 'package:lihat_lukis/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Apabila user telah login
            return const HomePage();
          } else {
            // Apabila user belum login
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
