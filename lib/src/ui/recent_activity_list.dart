import 'package:flutter/cupertino.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'Translated Spanish document',
        'time': '2 hours ago',
        'icon': CupertinoIcons.globe,
      },
      {
        'title': 'Generated Python code',
        'time': '5 hours ago',
        'icon': CupertinoIcons.chevron_left_slash_chevron_right,
      },
      {
        'title': 'Wrote marketing email',
        'time': '1 day ago',
        'icon': CupertinoIcons.mail,
      },
      {
        'title': 'Summarized research paper',
        'time': '2 days ago',
        'icon': CupertinoIcons.doc_text,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label,
          ),
        ),
        SizedBox(height: 12),
        ...activities.map(
          (activity) => Container(
            margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    activity['icon'] as IconData,
                    size: 16,
                    color: CupertinoColors.systemBlue,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity['title'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: CupertinoColors.label,
                        ),
                      ),
                      Text(
                        activity['time'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
