import 'package:flutter/material.dart';

enum CustomSize { small, medium, large, full }

enum BadgeVariant { low, moderate, high, other }

final badgeColor = {
  BadgeVariant.low: Colors.greenAccent,
  BadgeVariant.moderate: Colors.orange,
  BadgeVariant.high: Colors.red,
  BadgeVariant.other: Colors.blueAccent
};
