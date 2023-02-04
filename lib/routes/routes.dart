import 'package:flutter/material.dart';
import 'package:todo_list/middleware/auth_navigator.dart';
import 'package:todo_list/ui/screens/index.dart';

final customRoutes = <String, WidgetBuilder>{
  '/': (context) => const AuthNavigator(child: Home()),
  '/sign-up': (context) => const SignUp(),
  '/sign-in': (context) => const SignIn(),
  '/splash-screen': (context) => const SplashScreen(),
};
