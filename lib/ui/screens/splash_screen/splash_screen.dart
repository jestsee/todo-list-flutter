import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider/provider.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // executes after build
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final session = await ref.read(authRepositoryProvider).initialSession;
        if (session == null) {
          log('SESSION NULL');
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/sign-in', (Route<dynamic> route) => false);
          return;
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home-initial', (Route<dynamic> route) => false);
      });
      return null;
    }, const []);
    return const Scaffold(
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(32.0), child: Text('splash screen'))),
    );
  }
}
