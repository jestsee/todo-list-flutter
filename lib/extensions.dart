import 'package:flutter/material.dart';

extension ShowSnackBar on GlobalKey<ScaffoldMessengerState> {
  void show({
    required String message,
    Color bg = Colors.green,
  }) {
    final SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: bg,
    );
    currentState?.showSnackBar(snackBar);
  }

  void showError({required String message}) {
    show(message: message, bg: Colors.red);
  }
}

extension ShowDialog on GlobalKey<NavigatorState> {
  void showMyDialog() {
    showDialog(
        context: currentContext!,
        builder: (context) => const Center(
              child: Material(
                color: Colors.transparent,
                child: Text('Hello'),
              ),
            ));
  }
}
