import 'package:flutter/material.dart';
import 'package:todo_list/globals.dart';

void showSnackBar(
    {required String message,
    Color bg = Colors.green,
    Duration duration = const Duration(seconds: 1)}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: bg,
    duration: duration,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}

void errorSnackbar({required String message}) {
  showSnackBar(
      message: message,
      bg: Colors.redAccent,
      duration: const Duration(seconds: 2));
}

void infoSnackbar({required String message}) {
  showSnackBar(message: message, bg: Colors.blueGrey.shade700);
}
