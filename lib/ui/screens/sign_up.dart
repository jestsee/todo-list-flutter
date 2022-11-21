import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/ui/validator/validator.dart';

class SignUp extends HookWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // key
    final formKey = GlobalKey<FormState>();

    // state
    final hidePassword = useState(true);
    final hideConfirmPassword = useState(true);

    // controllers
    final nameController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');
    final passwordConfirmController = useTextEditingController(text: '');

    // instantiate
    final validator = Validator();

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
            const SizedBox(height: 8),
            const Text('Please fill the details to create account'),
            Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      validator: ((value) => validator.name(value!)),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'John Doe',
                          labelText: 'Name *'),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: ((value) => validator.email(value!)),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'example@mail.com',
                          labelText: 'Email *'),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (((value) => validator.password(value!))),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (() =>
                                  hidePassword.value = !hidePassword.value),
                              icon: const Icon(Icons.remove_red_eye)),
                          icon: const Icon(Icons.lock),
                          labelText: 'Password *'),
                      obscureText: hidePassword.value,
                    ),
                    TextFormField(
                      controller: passwordConfirmController,
                      validator: (((value) => value != passwordController.text ? 'ga match' : null)),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: (() =>
                                  hideConfirmPassword.value = !hideConfirmPassword.value),
                              icon: const Icon(Icons.remove_red_eye)),
                          icon: const Icon(Icons.lock_outline),
                          labelText: 'Confirm Password *'),
                      obscureText: hideConfirmPassword.value,
                    ),
                  ],
                )),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            )
          ],
        ),
      )),
    );
  }
}
