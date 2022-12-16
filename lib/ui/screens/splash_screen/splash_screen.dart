import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/provider.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<UserState>(
      authControllerProvider,
      (_, next) {
        Timer(const Duration(seconds: 0), () {
          next.maybeWhen(
              event: ((event) => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false)),
              orElse: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/sign-in', (Route<dynamic> route) => false));
        });
      },
    );

    return const Scaffold(
      body: Center(child: Text('splash screen 3 detik')),
    );
  }
}
