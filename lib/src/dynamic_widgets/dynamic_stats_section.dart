import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/widgets/stat_item.dart';
import 'package:ai_prompt_driven_app/src/config/stats_section_config.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';

class DynamicStatsSection extends StatelessWidget {
  const DynamicStatsSection({this.config, super.key});

  final StatsSectionConfig? config;

  @override
  Widget build(BuildContext context) {
    return Visibility(visible: config?.visible ?? true, child: _buildStatsSection());
  }

  Widget _buildStatsSection() {
    // Show empty container if no config provided
    if (config == null) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatItem(value: '--', label: 'Conversations'),
            StatItem(value: '--', label: 'Days Active'),
            StatItem(value: '--', label: 'Words Generated'),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(config!.padding ?? 20),
      decoration: BoxDecoration(
        color: WidgetParser.parseColor(config!.backgroundColor) ?? CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(config!.borderRadius ?? 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatItem(value: config!.conversationsValue, label: config!.conversationsLabel),
          StatItem(value: config!.daysActiveValue, label: config!.daysActiveLabel),
          StatItem(value: config!.wordsGeneratedValue, label: config!.wordsGeneratedLabel),
        ],
      ),
    );
  }
}
