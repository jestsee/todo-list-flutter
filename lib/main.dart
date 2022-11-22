import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/ui/screens/sign_up.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final formkey = GlobalKey();

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