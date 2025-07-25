import 'package:ai_prompt_driven_app/src/model/stat_card_config.dart';
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
        color: _parseColor(config!.backgroundColor) ?? CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(config!.borderRadius ?? 12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (config!.icon != null)
            Icon(
              _parseIcon(config!.icon!),
              size: 24,
              color: _parseColor(config!.iconColor) ?? CupertinoColors.systemBlue,
            ),
          if (config!.icon != null) SizedBox(height: 8),
          Text(
            config!.value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _parseColor(config!.valueColor) ?? CupertinoColors.label,
            ),
          ),
          Text(
            config!.title,
            style: TextStyle(
              fontSize: 12,
              color: _parseColor(config!.titleColor) ?? CupertinoColors.secondaryLabel,
            ),
          ),
        ],
      ),
    );
  }

  Color? _parseColor(dynamic colorValue) {
    if (colorValue == null) return null;

    if (colorValue is String) {
      // Handle hex color strings
      if (colorValue.startsWith('#')) {
        final hexColor = colorValue.substring(1);
        return Color(int.parse('FF$hexColor', radix: 16));
      } else if (colorValue.length == 8 || colorValue.length == 6) {
        // Handle hex strings without # (like 'FF000000' or '000000')
        final hexColor = colorValue.length == 6 ? 'FF$colorValue' : colorValue;
        return Color(int.parse(hexColor, radix: 16));
      }

      // Handle named colors
      switch (colorValue.toLowerCase()) {
        case 'white':
          return Colors.white;
        case 'black':
          return Colors.black;
        case 'red':
          return Colors.red;
        case 'blue':
          return Colors.blue;
        case 'green':
          return Colors.green;
        case 'orange':
          return Colors.orange;
        case 'purple':
          return Colors.purple;
        case 'grey':
        case 'gray':
          return Colors.grey;
        case 'transparent':
          return Colors.transparent;
        default:
          return null;
      }
    }

    if (colorValue is Map<String, dynamic>) {
      final r = colorValue['r'] ?? 0;
      final g = colorValue['g'] ?? 0;
      final b = colorValue['b'] ?? 0;
      final a = colorValue['a'] ?? 255;
      return Color.fromARGB(a, r, g, b);
    }

    return null;
  }

  IconData _parseIcon(String iconName) {
    // Map string names to IconData
    switch (iconName.toLowerCase()) {
      case 'star':
        return Icons.star;
      case 'home':
        return Icons.home;
      case 'person':
        return Icons.person;
      case 'trending_up':
        return Icons.trending_up;
      case 'trending_down':
        return Icons.trending_down;
      case 'bar_chart':
        return Icons.bar_chart;
      case 'pie_chart':
        return Icons.pie_chart;
      case 'show_chart':
        return Icons.show_chart;
      case 'attach_money':
        return Icons.attach_money;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'people':
        return Icons.people;
      case 'favorite':
        return Icons.favorite;
      case 'thumb_up':
        return Icons.thumb_up;
      case 'visibility':
        return Icons.visibility;
      case 'download':
        return Icons.download;
      case 'upload':
        return Icons.upload;
      case 'check_circle':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      case 'info':
        return Icons.info;
      case 'chat_bubble_2':
        return Icons.chat_bubble_outline;
      case 'globe':
        return Icons.language;
      default:
        return Icons.analytics; // Default fallback icon
    }
  }
}