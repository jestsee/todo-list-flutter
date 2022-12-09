import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/ui/screens/sign_up/sign_up.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authControllerState = ref.read(authControllerProvider);

    useEffect(() {
      if (authControllerState == null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignUp()));
        });
      }
      return () {};
    }, const []);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: const Center(
          child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(child: Text('Ini home🏠')),
      )),
    );
  }
}
