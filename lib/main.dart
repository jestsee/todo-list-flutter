import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/controllers/auth_controller.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SignUp(),
      ),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = useState(0);
    final authControllerState = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(authControllerState?.email ?? "blom login"),
          Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SignUp extends HookWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // state
    final hidePassword = useState(true);

    // controllers
    final nameController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Sign Up',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text('Please fill the details to create account'),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'John Doe',
                labelText: 'Name *'),
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'example@mail.com',
                labelText: 'Email *'),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: (() => hidePassword.value = !hidePassword.value),
                    icon: const Icon(Icons.remove_red_eye)),
                icon: const Icon(Icons.lock),
                labelText: 'Password *'),
            obscureText: hidePassword.value,
          ),
        ],
      )),
    );
  }
}
