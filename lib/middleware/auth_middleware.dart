import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/provider/provider.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';

class AuthNavigator extends HookConsumerWidget {
  final Widget child;
  const AuthNavigator({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.watch(authStateChangesProvider);
    log('masuk middleware ${currentState.value?.event.toString()}');
    if (currentState.value == null ||
        currentState.value?.event == AuthChangeEvent.signedOut) {
      return const SignIn();
    }
    return child;
  }
}
