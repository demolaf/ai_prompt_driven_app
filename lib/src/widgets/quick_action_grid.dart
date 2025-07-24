import 'package:flutter/cupertino.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'title': 'Translate', 'icon': CupertinoIcons.globe},
      {'title': 'Summarize', 'icon': CupertinoIcons.doc_text},
      {
        'title': 'Code Help',
        'icon': CupertinoIcons.chevron_left_slash_chevron_right,
      },
      {'title': 'Write Email', 'icon': CupertinoIcons.mail},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label,
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: CupertinoColors.systemBlue.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    action['icon'] as IconData,
                    size: 20,
                    color: CupertinoColors.systemBlue,
                  ),
                  SizedBox(width: 8),
                  Text(
                    action['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.label,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
