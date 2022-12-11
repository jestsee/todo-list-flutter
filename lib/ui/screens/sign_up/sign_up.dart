import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/ui/screens/sign_up/sign_up_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Text('Please fill the details to create account'),
            const SizedBox(height: 32),
            SignUpForm(),
            const SizedBox(height: 16),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                    children: <TextSpan>[
                  const TextSpan(text: 'Already have an account? '),
                  TextSpan(
                      text: 'Sign in',
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Navigator.pushNamed(context, '/sign-in'))
                ]))
          ],
        ),
      ),
    );
  }
}

// TODO uninstall string validator?
// TODO kalo udah install riverpod_hooks yg flutter_hooks di-uninstall aja?
// TODO refactor pisahin widget untuk form sendiri