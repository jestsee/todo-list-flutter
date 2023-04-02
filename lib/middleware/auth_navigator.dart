import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/screens/sign_in/sign_in.dart';
import 'package:todo_list/extensions.dart';
import 'package:todo_list/ui/widgets/wrapper.dart';

class AuthNavigator extends ConsumerWidget {
  final Widget child;
  const AuthNavigator({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // macro handler for snackbar
    ref.listen(authControllerProvider, (_, next) {
      next.whenOrNull(
        error: ((error, stackTrace) =>
            snackbarKey.showError(message: error.toString())),
      );
    });

    return ref.watch(authControllerProvider).maybeWhen(
          data: (event) => event?.session == null
              ? const SignIn()
              : ScaffoldWrapper(child: child),
          orElse: () => const SignIn(),
        );
  }
}
