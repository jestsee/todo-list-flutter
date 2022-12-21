import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';
import 'package:todo_list/utils.dart';

class AuthNavigator extends HookConsumerWidget {
  final Widget child;
  const AuthNavigator({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authControllerProvider, (prev, next) {
      if (prev is Initial || prev == next || next is! Event) return;
      if (next.event.event == AuthChangeEvent.signedIn) {
        snackbarKey.show(message: 'Successfully signed in');
      }
    });
    return ref.watch(authControllerProvider).maybeWhen(
          event: (event) => event.session != null ? child : const SignIn(),
          orElse: () => const SignIn(),
        );
  }
}
