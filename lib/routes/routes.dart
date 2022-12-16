import 'package:flutter/material.dart';
import 'package:todo_list/middleware/auth_navigator.dart';
import 'package:todo_list/ui/screens/home/home.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';
import 'package:todo_list/ui/screens/sign_up/sign_up.dart';
import 'package:todo_list/ui/screens/splash_screen/splash_screen.dart';

final customRoutes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),
  '/home': (context) => const AuthNavigator(child: Home()),
  '/home-initial': (context) => const AuthNavigator(first: true, child: Home()),
  '/sign-up': (context) => const SignUp(),
  '/sign-in': (context) => const SignIn(),
};
