import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/custom_button.dart';

void showEditNameDialog(BuildContext context) {
  showDialog(
      context: context, builder: ((context) => const ChangeNameDialog()));
}

class ChangeNameDialog extends HookConsumerWidget {
  const ChangeNameDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final nameController =
        useTextEditingController(text: profile.value?.name ?? '');
    return AlertDialog(
      title: const Text("Change name"),
      content: TextField(
        controller: nameController,
        decoration: const InputDecoration(labelText: 'Enter new name'),
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
            if (profile.value?.name != nameController.text) {
              ref
                  .read(profileControllerProvider.notifier)
                  .updateName(nameController.text);
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
