import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/custom_button.dart';
import 'package:todo_list/ui/validator/validation_message.dart' as v;

void showEditNameDialog(BuildContext context) {
  showDialog(
      context: context, builder: ((context) => const ChangeNameDialog()));
}

class ChangeNameDialog extends HookConsumerWidget {
  const ChangeNameDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final msg = useMemoized(() => const v.ValidationMessage());

    final form = useState(FormGroup({
      'name': FormControl<String>(
          value: profile.value?.name,
          touched: true,
          validators: [Validators.required])
    }));

    String getNewName() => form.value.control('name').value;

    return AlertDialog(
      title: const Text("Change name"),
      content: ReactiveForm(
        formGroup: form.value,
        child: ReactiveTextField(
          formControlName: 'name',
          decoration: const InputDecoration(labelText: 'Enter new name'),
          validationMessages: {'required': (_) => msg.required('New name')},
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
            if (!form.value.valid) return;
            if (profile.value?.name != getNewName()) {
              ref
                  .read(profileControllerProvider.notifier)
                  .updateName(getNewName());
            }
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
