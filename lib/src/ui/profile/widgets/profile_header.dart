import 'package:flutter/cupertino.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CupertinoColors.systemGrey5,
          ),
          child: Icon(
            CupertinoIcons.person_fill,
            size: 60,
            color: CupertinoColors.systemGrey,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'John Doe',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.label,
          ),
        ),
        Text(
          'john.doe@example.com',
          style: TextStyle(fontSize: 16, color: CupertinoColors.secondaryLabel),
        ),
      ],
    );
  }
}
