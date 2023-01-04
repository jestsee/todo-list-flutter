import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomForm extends StatelessWidget {
  final Map<String, String Function(Object)>? validator;
  final Icon? leading;
  final String name;
  final String? placeholder, label;
  final bool? obscureText;
  final Widget? suffixIcon;
  const CustomForm(
      {super.key,
      required this.name,
      this.validator,
      this.leading,
      this.placeholder,
      this.obscureText,
      this.label,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: name,
      validationMessages: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: leading,
        hintText: placeholder ?? name,
        labelText: label ?? name,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
