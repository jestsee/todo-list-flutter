import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/custom_button.dart';
import 'package:todo_list/ui/validator/validation_message.dart' as v;
import 'package:todo_list/ui/widgets/password_form.dart';

void showPasswordDialog(BuildContext context) {
  showDialog(context: context, builder: ((context) => const PasswordDialog()));
}

class PasswordDialog extends HookConsumerWidget {
  const PasswordDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final msg = useMemoized(() => const v.ValidationMessage());

    final form = useState(FormGroup({
      'oldPassword': FormControl<String>(
          validators: [Validators.required, Validators.minLength(6)]),
      'newPassword': FormControl<String>(
          validators: [Validators.required, Validators.minLength(6)]),
    }));

    String getOldPassword() => form.value.control('oldPassword').value;
    String getNewPassword() => form.value.control('newPassword').value;

    return AlertDialog(
      title: const Text("New password"),
      content: ReactiveForm(
        formGroup: form.value,
        child: Wrap(
          children: [
            PasswordForm(
              name: 'oldPassword',
              placeholder: 'Old password',
              label: 'Enter old password',
              validator: {'required': (_) => msg.required('Old password')},
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            PasswordForm(
              name: 'newPassword',
              placeholder: 'New password',
              label: 'Enter new password',
              validator: {'required': (_) => msg.required('New password')},
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        CustomButton(
          onPressed: () {
            form.value.markAllAsTouched();
            if (!form.value.valid) return;
            ref
                .read(profileControllerProvider.notifier)
                .updatePassword(getOldPassword(), getNewPassword());
            if (!profile.isLoading && !profile.hasError) {
              Navigator.of(context).pop();
            }
          },
          loading: ref.watch(profileControllerProvider).isLoading,
          child: const Text("OK"),
        ),
      ],
    );
  }
}
