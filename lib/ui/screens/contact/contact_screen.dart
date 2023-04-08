import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: ref.watch(contactControllerProvider).when(
              loading: () => const Text('Loading...'),
              error: (e, st) => const Text('Error...'),
              data: (data) {
                if (data == null) return const Text('No contacts found');
                return ListView.separated(
                  separatorBuilder: ((context, index) => const SizedBox(
                        height: 18,
                      )),
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final item = data[index];
                    return ListTile(
                      title: Text(item.displayName),
                      subtitle: Text(item.phones[0].number),
                      tileColor: Colors.white,
                      style: ListTileStyle.drawer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          item.displayName[0],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
      ),
    );
  }
}
