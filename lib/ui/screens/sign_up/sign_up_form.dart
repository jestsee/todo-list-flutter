import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo_list/ui/validator/validation_message.dart' as v;
import 'package:todo_list/utils.dart';
import '../../widgets/custom_form.dart';

class SignUpForm extends HookWidget {
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

  @override
  Widget build(BuildContext context) {
    final msg = useMemoized(() => const v.ValidationMessage());
    return Column(
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
                CustomForm(
                    name: 'name',
                    label: 'Name *',
                    leading: const Icon(Icons.person),
                    placeholder: 'John Doe',
                    validator: {
                      'required': (_) => msg.required('Password'),
                    }),
                CustomForm(
                    name: 'email',
                    label: 'Email *',
                    leading: const Icon(Icons.mail),
                    placeholder: 'example@mail.com',
                    validator: {
                      'required': (_) => msg.required('Email'),
                      'email': (_) => msg.email()
                    }),
                CustomForm(
                  name: 'password',
                  label: 'Password *',
                  leading: const Icon(Icons.lock),
                  validator: {
                    'required': (_) => msg.required('Password'),
                    'minLength': (error) => msg.minLength(
                        'Password', (error as Map)['requiredLength'])
                  },
                ),
              ],
            )),
        ElevatedButton(
          onPressed: () {
            print(form.value);
            form.valid
                ? context.showSnackBar(message: 'cihuy')
                : context.showErrorSnackBar(message: 'blm valid oi');
          },
          child: const Text('Sign Up'),
        )
      ],
    );
  }
}
