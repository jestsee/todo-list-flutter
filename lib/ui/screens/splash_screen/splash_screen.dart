import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/services/notification_service.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      NotificationService.init(initSchedule: true);
      return null;
    }, const []);

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    });

    return const Scaffold(
      body: Center(child: Text('splash screen 3 detik')),
    );
  }
}
