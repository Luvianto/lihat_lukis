import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lihat_lukis/components/my_button.dart';
import 'package:lihat_lukis/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sign user in
  void signIn() async {
    // loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // Agar loading tidak hilang saat di tap user
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try to sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      // pop loading circle
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseException catch (e) {
      // pop loading circle
      Navigator.pop(context);

      // display a dialog message
      displayMessage(e.code);
    }
  }

  //display a dialog mesaage
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Text(
          formatErrorMessage(message),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  String formatErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'Pengguna dengan email ini tidak ditemukan. Silakan periksa kembali dan coba lagi.';
      case 'wrong-password':
        return 'Kata sandi salah. Silakan coba lagi.';
      case 'invalid-credential':
        return 'Silakan periksa kembali email atau kata sandi Anda.';
      case 'email-already-in-use':
        return 'Email ini sudah digunakan. Silakan gunakan email lain.';
      case 'invalid-email':
        return 'Alamat email tidak valid. Silakan masukkan email yang valid.';
      case 'network-request-failed':
        return 'Kesalahan jaringan. Periksa koneksi internet Anda.';
      default:
        return 'Terjadi kesalahan tak terduga. Silakan coba lagi nanti.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                //logo
                const CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('lib/images/app_icon.png'),
                ),

                const SizedBox(height: 50),

                //welcome back message
                Text(
                  'Selamat Datang Kembali!',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: passwordTextController,
                  hintText: 'Kata sandi',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                //sign in button
                MyButton(onTap: signIn, text: 'LOGIN'),

                const SizedBox(height: 20),

                // go to register page
                Text(
                  'Belum memiliki akun? ',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Daftar sekarang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
