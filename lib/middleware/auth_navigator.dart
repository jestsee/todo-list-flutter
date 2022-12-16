import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/provider/provider.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';

class AuthNavigator extends HookConsumerWidget {
  final Widget child;
  final bool first;
  const AuthNavigator({super.key, required this.child, this.first=false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = ref.watch(authStateChangesProvider);
    final _first = useState(first);
    
    if (_first.value) {
      _first.value = false;
      log('first value: ${_first.value}');
      return child;
    }
    
    log('[middleware] ${currentState.value?.event.toString()}');
    if (currentState.value == null ||
        currentState.value?.event == AuthChangeEvent.signedOut) {
      return const SignIn();
    }
    return child;
  }
}
