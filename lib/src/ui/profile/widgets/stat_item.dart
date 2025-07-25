import 'package:flutter/cupertino.dart';

class StatItem extends StatelessWidget {
  const StatItem({required this.value, required this.label, super.key});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.systemBlue,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel),
        ),
      ],
    );
  }
}
