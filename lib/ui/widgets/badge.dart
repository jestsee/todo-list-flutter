import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/constants.dart';

class Badge extends StatelessWidget {
  final String text;
  final bool outline;
  final BadgeVariant variant;
  const Badge(
      {super.key,
      this.outline = false,
      this.variant = BadgeVariant.low,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          color: !outline ? badgeColor[variant] : null,
          border:
              outline ? Border.all(color: badgeColor[variant] as Color) : null,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        text,
        style: TextStyle(
            color: outline ? badgeColor[variant] : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12),
      ),
    );
  }
}
