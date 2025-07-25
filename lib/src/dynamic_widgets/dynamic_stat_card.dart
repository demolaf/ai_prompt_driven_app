import 'package:ai_prompt_driven_app/src/model/stat_card_config.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicStatCard extends StatelessWidget {
  const DynamicStatCard({
    this.config,
    super.key,
  });

  final StatCardConfig? config;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: config?.visible ?? true,
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    // Show empty container if no config provided
    if (config == null) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.analytics,
              size: 24,
              color: CupertinoColors.systemGrey,
            ),
            SizedBox(height: 8),
            Text(
              '--',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemGrey,
              ),
            ),
            Text(
              'No data',
              style: TextStyle(
                fontSize: 12,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(config!.padding ?? 16),
      decoration: BoxDecoration(
        color: WidgetParser.parseColor(config!.backgroundColor) ?? CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(config!.borderRadius ?? 12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (config!.icon != null)
            Icon(
              WidgetParser.parseIcon(config!.icon!),
              size: 24,
              color: WidgetParser.parseColor(config!.iconColor) ?? CupertinoColors.systemBlue,
            ),
          if (config!.icon != null) SizedBox(height: 8),
          Text(
            config!.value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: WidgetParser.parseColor(config!.valueColor) ?? CupertinoColors.label,
            ),
          ),
          Text(
            config!.title,
            style: TextStyle(
              fontSize: 12,
              color: WidgetParser.parseColor(config!.titleColor) ?? CupertinoColors.secondaryLabel,
            ),
          ),
        ],
      ),
    );
  }

}