import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MomentCategory {
  MomentCategory(
      {required this.name, required this.icon, required this.keywords});
  String name;
  IconData icon;
  List<String> keywords;
}

final List<MomentCategory> momentCategories = [
  MomentCategory(
      name: 'Sports',
      icon: Icons.fitness_center,
      keywords: ["sports", "practice", "excercise", "football", "soccer"]),
  MomentCategory(name: 'Commute', icon: Icons.commute, keywords: [
    "commute",
    "travel",
    "car",
    "bus",
    "bike",
    "walk",
    "ride",
    "drive"
  ]),
  MomentCategory(
      name: 'Spotlight',
      icon: Icons.center_focus_weak,
      keywords: ["spotlight", "center", "attention", "focus", "tension"]),
  MomentCategory(name: 'Devices', icon: Icons.devices, keywords: [
    "technology",
    "phone",
    "laptop",
    "computer",
    "screens",
    "devices",
    "social",
    "media",
    "electronics"
  ]),
];
