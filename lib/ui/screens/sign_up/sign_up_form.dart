import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/ui/validator/validation_message.dart' as v;
import 'package:todo_list/utils.dart';
import '../../widgets/custom_form.dart';

class SignUpForm extends HookConsumerWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  final form = FormGroup({
    // TODO alpha numeric only
    'name': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)])
  });

// getters
  String get name => form.control('name').value;
  String get email => form.control('email').value;
  String get password => form.control('password').value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msg = useMemoized(() => const v.ValidationMessage());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // const SizedBox(height: 32),
        ReactiveForm(
            formGroup: form,
            child: Wrap(
              runSpacing: 18,
              children: <Widget>[
                CustomForm(
                    name: 'name',
                    label: 'Name *',
                    // leading: const Icon(Icons.person),
                    placeholder: 'John Doe',
                    validator: {
                      'required': (_) => msg.required('Name'),
                    }),
                CustomForm(
                    name: 'email',
                    label: 'Email *',
                    // leading: const Icon(Icons.mail),
                    placeholder: 'example@mail.com',
                    validator: {
                      'required': (_) => msg.required('Email'),
                      'email': (_) => msg.email()
                    }),
                CustomForm(
                  name: 'password',
                  label: 'Password *',
                  // leading: const Icon(Icons.lock),
                  validator: {
                    'required': (_) => msg.required('Password'),
                    'minLength': (error) => msg.minLength(
                        'Password', (error as Map)['requiredLength'])
                  },
                ),
              ],
            )),
        const SizedBox(
          height: 36,
        ),
        ElevatedButton(
          onPressed: () {
            log(form.value.toString());
            if (!form.valid) {
              return context.showErrorSnackBar(message: 'blm valid oi');
            }
            ref
                .read(authControllerProvider.notifier)
                .signUp(email, password, name);
            context.showSnackBar(message: 'cihuy');
            Navigator.pushNamed(context, '/');
          },
          child: const Text('Sign Up'),
        )
      ],
    );
  }
}
