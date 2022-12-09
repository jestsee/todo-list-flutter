import 'package:flutter/material.dart';
import 'package:todo_list/ui/screens/sign_up/sign_up_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SignUpForm(),
      )),
    );
  }
}

// TODO uninstall string validator?
// TODO kalo udah install riverpod_hooks yg flutter_hooks di-uninstall aja?
// TODO refactor pisahin widget untuk form sendiri