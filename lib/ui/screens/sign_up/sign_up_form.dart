import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/validator/validation_message.dart' as v;
import 'package:todo_list/ui/widgets/custom_form.dart';
import 'package:todo_list/extensions.dart';
import 'package:todo_list/ui/widgets/password_form.dart';

class SignUpForm extends HookConsumerWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final msg = useMemoized(() => const v.ValidationMessage());
    final form = useState(FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(
          validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(
          validators: [Validators.required, Validators.minLength(6)])
    }));

// getters
    String getName() => form.value.control('name').value;
    String getEmail() => form.value.control('email').value;
    String getPassword() => form.value.control('password').value;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // const SizedBox(height: 32),
        ReactiveForm(
            formGroup: form.value,
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
                PasswordForm(
                  name: 'password',
                  label: 'Password *',
                  isDirty: form.value.control('password').dirty,
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
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
          ),
          onPressed: () {
            log(form.value.toString());
            if (!form.value.valid) {
              return snackbarKey.showError(message: 'Invalid input');
            }
            ref
                .read(authControllerProvider.notifier)
                .signUp(getEmail(), getPassword(), getName());
            // TODO
            snackbarKey.show(message: 'cihuy');
          },
          child: const Text(
            'Getting Started',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
