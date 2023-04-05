import 'package:flutter/material.dart';

class TaskFilter extends StatelessWidget {
  const TaskFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.all(3),
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: Colors.white,
            )));
  }
}
