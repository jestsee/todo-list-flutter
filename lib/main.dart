import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackground = "fetchBackground";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    log('masuk woii');
    switch (task) {
      case fetchBackground:
        log('masuk callbackaa');
        break;
    }
    return Future.value(true);
  });
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_SECRET']!,
    authCallbackUrlHostname: 'login-callback',
  );

  // work manager
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Workmanager().registerPeriodicTask(
        "1",
        fetchBackground,
        frequency: const Duration(minutes: 1),
        constraints: Constraints(networkType: NetworkType.connected),
      );
      return null;
    }, const []);
    return ProviderScope(
      child: MaterialApp(
        title: 'Todo List Flutter',
        scaffoldMessengerKey: snackbarKey,
        navigatorKey: navigatorKey,
        initialRoute: '/splash-screen',
        routes: customRoutes,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSwatch(
                accentColor: Colors.blue,
                backgroundColor: Colors.grey.shade200),
            textTheme: TextTheme(
              displayLarge: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              displayMedium: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              displaySmall: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headlineMedium:
                  TextStyle(fontSize: 12, color: Colors.grey.shade600),
              headlineSmall:
                  TextStyle(fontSize: 18, color: Colors.grey.shade600),
            )),
      ),
    );
  }
}
