import 'package:flutter/cupertino.dart';

class StatItem extends StatelessWidget {
  const StatItem({super.key, required this.value, required this.label});

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
