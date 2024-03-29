import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/screens/profile/name_dialog.dart';
import 'package:todo_list/ui/screens/profile/password_dialog.dart';

class Profile extends HookConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonTheme = ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16));

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ref.watch(profileControllerProvider).whenOrNull(
              loading: () => const Text('Loading...'),
              data: (item) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        CircleAvatar(
                          backgroundImage: item.avatarUrl != null
                              ? NetworkImage(item.avatarUrl!)
                              : null,
                          backgroundColor: const Color(0xff00A3FF),
                          radius: 56.0,
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border:
                                      Border.all(width: 3, color: Colors.white),
                                  borderRadius: BorderRadius.circular(99)),
                              child: IconButton(
                                padding: const EdgeInsets.only(right: 0),
                                icon: Icon(
                                  Icons.edit_rounded,
                                  color: Colors.blueGrey.shade50,
                                  size: 16,
                                ),
                                onPressed: (() {
                                  ref
                                      .read(profileControllerProvider.notifier)
                                      .updateProfilePicture();
                                }),
                              ),
                            ))
                      ]),
                      const SizedBox(height: 32),
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ref.watch(taskListControllerProvider).when(
                            data: (data) => data.isNotEmpty
                                ? 'You have ${data.length} tasks'
                                : 'All tasks done!',
                            error: (err, st) => 'Something went wrong',
                            loading: () => 'Loading...'),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 52),
                      ElevatedButton(
                          onPressed: () => showNameDialog(context),
                          style: buttonTheme,
                          child: Row(
                            children: [
                              Icon(Icons.edit_rounded,
                                  size: 28, color: Colors.grey.shade600),
                              const SizedBox(width: 12),
                              Text(
                                'Change name',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          )),
                      const SizedBox(height: 28),
                      ElevatedButton(
                          onPressed: () => showPasswordDialog(context),
                          style: buttonTheme,
                          child: Row(
                            children: [
                              Icon(Icons.lock_rounded,
                                  size: 28, color: Colors.grey.shade600),
                              const SizedBox(width: 12),
                              Text(
                                'Change password',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          )),
                      const SizedBox(height: 28),
                      ElevatedButton(
                          onPressed: () => ref
                              .read(authControllerProvider.notifier)
                              .signOut(),
                          style: buttonTheme,
                          child: Row(
                            children: [
                              Icon(Icons.logout_rounded,
                                  size: 28, color: Colors.grey.shade600),
                              const SizedBox(width: 12),
                              Text(
                                'Sign out',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          )),
                    ],
                  )),
        ),
      ),
    );
  }
}
