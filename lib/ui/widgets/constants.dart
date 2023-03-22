import 'package:flutter/material.dart';

enum CustomSize { small, medium, large, full }

enum BadgeVariant { low, medium, high, other }

final badgeColor = {
  BadgeVariant.low: Colors.greenAccent,
  BadgeVariant.medium: Colors.orange,
  BadgeVariant.high: Colors.redAccent,
  BadgeVariant.other: Colors.blueAccent
};
