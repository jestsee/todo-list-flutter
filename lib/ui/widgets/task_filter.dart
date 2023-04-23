import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/custom_button.dart';

import 'priority_chip.dart';

class TaskFilter extends HookWidget {
  const TaskFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.all(3),
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.filter_list_rounded,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              builder: (context) => const Filter(),
            );
          },
        ));
  }
}

class Filter extends HookConsumerWidget {
  const Filter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState<DateTime?>(ref.read(dateFilterProvider));
    final dateController = useTextEditingController(
        text: selectedDate.value != null
            ? DateFormat('dd MMMM yyyy').format(selectedDate.value!)
            : null);
    final selectedPriority =
        useState<Priority?>(ref.read(priorityFilterProvider));

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 36),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Priority', style: Theme.of(context).textTheme.displaySmall),
              TextButton(
                  onPressed: () {
                    ref.read(priorityFilterProvider.notifier).state = null;
                    ref.read(dateFilterProvider.notifier).state = null;
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Priority.values.reversed
                  .map((priority) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: PriorityChip(
                          priority: priority,
                          selected: selectedPriority.value == priority,
                          onPressed: () {
                            selectedPriority.value = priority;
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          Text('Date', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12),
          TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Filter by date',
                prefixIcon: Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade700,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onTap: (() async {
                selectedDate.value = await showDatePicker(
                    context: context,
                    initialDate: selectedDate.value ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2999));
                if (selectedDate.value != null) {
                  dateController.text =
                      DateFormat('dd MMMM yyyy').format(selectedDate.value!);
                }
              })),
          const SizedBox(height: 32),
          CustomButton(
            full: true,
            onPressed: (() {
              ref.read(priorityFilterProvider.notifier).state =
                  selectedPriority.value;
              ref.read(dateFilterProvider.notifier).state = selectedDate.value;
              Navigator.of(context).pop();
            }),
            child: const Text(
              'Apply',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
