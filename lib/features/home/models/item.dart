import 'package:flutter/material.dart';

class Item {
  final String title;
  final String subtitle;
  final bool completado;
  final IconData icon;

  Item({
    required this.title,
    required this.subtitle,
    required this.completado,
    required this.icon,
  });
}