import 'package:flutter/material.dart';

class AccuracyChip extends StatelessWidget {
  final String accuracyLabel;
  const AccuracyChip({super.key, required this.accuracyLabel});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(accuracyLabel));
  }
}
