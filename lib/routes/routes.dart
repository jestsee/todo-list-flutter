import 'package:flutter/material.dart';
import 'package:todo_list/middleware/auth_middleware.dart';
import 'package:todo_list/ui/screens/home/home.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';
import 'package:todo_list/ui/screens/sign_up/sign_up.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => const AuthNavigator(
        authRequired: true,
        child: Home(),
      ),
  '/sign-up': (context) => const SignUp(),
  '/sign-in': (context) => const SignIn(),
};
