import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in_form.dart';
import 'package:todo_list/ui/widgets/connect_with.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
              'Sign In',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            const Text('Please sign in to using our app'),
            const SizedBox(height: 32),
            SignInForm(),
            const SizedBox(height: 20),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                    children: <TextSpan>[
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => Navigator.pushNamed(context, '/sign-up'))
                ])),
                const SizedBox(height: 40,),
                const ConnectWith()
          ],
        ),
      ),
    );
  }
}
