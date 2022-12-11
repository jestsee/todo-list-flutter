import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/ui/screens/sign_up/sign_up.dart';

class AuthNavigator extends HookConsumerWidget {
  final Widget child;
  final bool authRequired;
  const AuthNavigator(
      {super.key, required this.child, this.authRequired = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!authRequired) return child;
    final authControllerState = ref.read(authControllerProvider);
    log('bismilah');
    if (authControllerState == null) return const SignUp();
    log(authControllerState.userMetadata.toString());
    return child;
  }
}
