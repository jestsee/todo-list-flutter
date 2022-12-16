import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomButton extends HookWidget {
  const CustomButton({
    super.key,
    this.leading,
    this.onPressed,
    this.disabled = false,
    this.loading = false,
    this.full = false,
    required this.child,
  });
  final Icon? leading;
  final Widget child;
  final bool loading;
  final bool disabled;
  final bool full;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: full
          ? ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            )
          : null,
      onPressed: !disabled && !loading ? onPressed : null,
      child: loading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : leading != null
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[leading!, child],
                )
              : child,
    );
  }
}
