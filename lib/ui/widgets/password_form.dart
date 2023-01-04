import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/ui/widgets/custom_form.dart';

class PasswordForm extends HookWidget {
  final Map<String, String Function(Object)>? validator;
  final String name;
  final String? placeholder, label;
  final bool isDirty;
  const PasswordForm(
      {super.key,
      required this.name,
      required this.isDirty,
      this.placeholder,
      this.label,
      this.validator});

  @override
  Widget build(BuildContext context) {
    final hidePassword = useState(true);

    return CustomForm(
      name: name,
      label: label,
      placeholder: placeholder,
      validator: validator,
      obscureText: hidePassword.value,
      suffixIcon: IconButton(
          onPressed: (() => hidePassword.value = !hidePassword.value),
          icon: hidePassword.value
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off)),
    );
  }
}
