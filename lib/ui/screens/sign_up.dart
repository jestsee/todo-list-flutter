import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo_list/ui/validator/validation_message.dart' as v;
import 'package:todo_list/utils.dart';

class SignUp extends HookWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final msg = useMemoized(() => const v.ValidationMessage());
    final hidePassword = useState(true);
    final hidePasswordConfirm = useState(true);
    final form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(
          validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(6)])
    });

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
            ReactiveForm(
                formGroup: form,
                child: Column(
                  children: <Widget>[
                    ReactiveTextField(
                      formControlName: 'name',
                      validationMessages: {
                        'required': (_) => msg.required('Name')
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'John Doe',
                          labelText: 'Name *'),
                    ),
                    ReactiveTextField(
                      formControlName: 'email',
                      validationMessages: {
                        'required': (_) => msg.required('Email'),
                        'email': (_) => msg.email()
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'example@mail.com',
                          labelText: 'Email *'),
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      obscureText: hidePassword.value,
                      validationMessages: {
                        'required': (_) => msg.required('Password'),
                        'minLength': (error) => msg.minLength(
                            'Password', (error as Map)['requiredLength'])
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (() =>
                                  hidePassword.value = !hidePassword.value),
                              icon: const Icon(Icons.remove_red_eye)),
                          icon: const Icon(Icons.lock),
                          labelText: 'Password *'),
                    ),
                  ],
                )),
            ElevatedButton(
              onPressed: () {
                print(form.value);
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
// TODO refactor pisahin widget untuk form sendiri