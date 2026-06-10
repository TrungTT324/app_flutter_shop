import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}
