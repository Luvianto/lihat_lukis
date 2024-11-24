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
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Sebuah error terjadi, mohon coba lagi dalam beberapa saat.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
