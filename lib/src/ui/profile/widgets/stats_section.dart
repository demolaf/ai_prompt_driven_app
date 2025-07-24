import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/widgets/stat_item.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatItem(value: '1,247', label: 'Conversations'),
          StatItem(value: '35', label: 'Days Active'),
          StatItem(value: '2.4k', label: 'Words Generated'),
        ],
      ),
    );
  }
}
