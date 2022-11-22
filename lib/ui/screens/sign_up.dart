import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/hooks/use_sign_up.dart';
import 'package:todo_list/ui/validator/validator.dart';
import 'package:todo_list/utils.dart';

class SignUp extends HookWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = useSignUp();
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final validator = useMemoized(() => Validator());

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
            ),
            // const SizedBox(height: 16),
            const Text('Please fill the details to create account'),
            // const SizedBox(height: 32),
            Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: fields.name.controller,
                      focusNode: fields.name.focus,
                      validator: ((value) => fields.name.touched.value
                          ? validator.name(value!)
                          : null),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'John Doe',
                          labelText: 'Name *'),
                    ),
                    TextFormField(
                      controller: fields.email.controller,
                      focusNode: fields.email.focus,
                      validator: ((value) => fields.email.touched.value
                          ? validator.email(value!)
                          : null),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'example@mail.com',
                          labelText: 'Email *'),
                    ),
                    TextFormField(
                      controller: fields.password.controller,
                      focusNode: fields.password.focus,
                      validator: (((value) => fields.password.touched.value
                          ? validator.password(value!)
                          : null)),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () => fields.togglePassword(),
                              icon: const Icon(Icons.remove_red_eye)),
                          icon: const Icon(Icons.lock),
                          labelText: 'Password *'),
                      obscureText: fields.hidePassword,
                    ),
                    TextFormField(
                      controller: fields.passwordConfirm.controller,
                      focusNode: fields.passwordConfirm.focus,
                      validator: (((value) => validator.passwordNotMatch(
                          value!, fields.password.controller.text))),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (() => fields.toggleConfirmPassword()),
                              icon: const Icon(Icons.remove_red_eye)),
                          icon: const Icon(Icons.lock_outline),
                          labelText: 'Confirm Password *'),
                      obscureText: fields.hideConfirmPassword,
                    ),
                  ],
                )),
            // const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                context.showSnackBar(message: 'cihuy');
              },
              child: const Text('Sign Up'),
            )
          ],
        ),
      )),
    );
  }
}

// TODO uninstall string validator?
// TODO kalo udah install riverpod_hooks yg flutter_hooks di-uninstall aja?