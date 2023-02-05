import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/badge.dart';
import 'package:todo_list/ui/widgets/constants.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Task name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Badge(
                text: 'Priority',
                variant: BadgeVariant.high,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Badge(
                text: 'Group',
                outline: true,
                variant: BadgeVariant.other,
              ),
              Row(
                children: const [
                  Icon(Icons.timelapse, size: 18),
                  SizedBox(width: 4),
                  Text('time/deadline'),
                ],
              )
            ],
          ),
          SizedBox(
            height: 32,
            child: CheckboxListTile(
              value: true,
              onChanged: ((value) => {}),
              title: const Text(
                'task 1',
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          CheckboxListTile(
            value: false,
            onChanged: ((value) => {}),
            title: const Text('task 1'),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
