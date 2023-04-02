import 'package:flutter/material.dart';

enum Priority {
  low,
  medium,
  high;

  String get name => toString().split('.').last;

  Priority switchPriority() {
    switch (this) {
      case low:
        return medium;
      case medium:
        return high;
      default:
        return low;
    }
  }
}

final priorityColor = {
  Priority.low: Colors.greenAccent,
  Priority.medium: Colors.orange,
  Priority.high: Colors.redAccent,
};
