import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider/provider.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';

class AuthNavigator extends HookConsumerWidget {
  final Widget child;
  final bool first;
  const AuthNavigator({super.key, required this.child, this.first = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authControllerProvider).maybeWhen(
          event: (event) => event.session != null ? child : const SignIn(),
          orElse: () => const SignIn(),
        );
  }
}
