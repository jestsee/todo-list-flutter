import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/validator/validation_message.dart' as v;
import 'package:todo_list/ui/widgets/custom_button.dart';
import 'package:todo_list/utils.dart';
import 'package:todo_list/ui/widgets/custom_form.dart';

class SignInForm extends HookConsumerWidget {
  SignInForm({
    Key? key,
  }) : super(key: key);

  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)])
  });

// getters
  String get email => form.control('email').value;
  String get password => form.control('password').value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msg = useMemoized(() => const v.ValidationMessage());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ReactiveForm(
            formGroup: form,
            child: Wrap(
              runSpacing: 18,
              children: <Widget>[
                CustomForm(
                    name: 'email',
                    label: 'Email *',
                    placeholder: 'example@mail.com',
                    validator: {
                      'required': (_) => msg.required('Email'),
                      'email': (_) => msg.email()
                    }),
                CustomForm(
                  name: 'password',
                  label: 'Password *',
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
        CustomButton(
          full: true,
          loading: ref.watch(authControllerProvider) is Loading,
          child: const Text(
            'Sign in',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            log(form.value.toString());
            if (!form.valid) {
              return snackbarKey.showError(message: 'belom oi');
            }
            ref.read(authControllerProvider.notifier).signIn(email, password);
          },
        )
      ],
    );
  }
}
