import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: const Center(
          child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Text('Ini halaman sign in'),
      )),
    );
  }
}
