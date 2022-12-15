import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/ui/screens/home/home.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';

class AuthNavigator extends HookConsumerWidget {
  final Widget child;
  const AuthNavigator(
      {super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.watch(authControllerProvider);
    final className = child.toString();
    log(className);
    log('[state read] ${authControllerState?.toJson()}');
    
    if (authControllerState == null) return const SignIn();
    if (className == 'SignIn' || className == 'SignUp') return const Home();
    return child;
  }
}
