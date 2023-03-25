import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_SECRET']!,
    authCallbackUrlHostname: 'login-callback',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Todo List Flutter',
        scaffoldMessengerKey: snackbarKey,
        navigatorKey: navigatorKey,
        initialRoute: '/splash-screen',
        routes: customRoutes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: const TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
            headline3: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            headline4: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            headline5: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            headline6: TextStyle(fontSize: 24, color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}
