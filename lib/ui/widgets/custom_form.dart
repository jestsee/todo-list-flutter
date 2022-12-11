import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomForm extends HookWidget {
  final Map<String, String Function(Object)>? validator;
  final Icon? leading;
  final String name;
  final String? placeholder, label;
  const CustomForm(
      {super.key,
      required this.name,
      this.validator,
      this.leading,
      this.placeholder,
      this.label});

  @override
  Widget build(BuildContext context) {
    final hidePassword = useState(true);

    return ReactiveTextField(
      formControlName: name,
      validationMessages: validator,
      obscureText: name == 'password' ? hidePassword.value : false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        icon: leading,
        hintText: placeholder,
        labelText: label,
        suffixIcon: name == 'password'
            ? IconButton(
                onPressed: (() => hidePassword.value = !hidePassword.value),
                icon: const Icon(Icons.remove_red_eye))
            : null,
      ),
    );
  }
}
