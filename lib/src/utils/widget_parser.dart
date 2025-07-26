import 'package:flutter/material.dart';

/// Utility class for parsing widget configuration values
class WidgetParser {
  WidgetParser._();

  /// Parses a color value from various formats
  static Color? parseColor(dynamic colorValue) {
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

  /// Parses an icon name string to IconData
  static IconData parseIcon(String iconName) {
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
      case 'settings':
        return Icons.settings;
      case 'notifications':
        return Icons.notifications;
      case 'moon':
        return Icons.dark_mode;
      case 'privacy':
        return Icons.privacy_tip;
      case 'security':
        return Icons.security;
      case 'location':
        return Icons.location_on;
      case 'help':
        return Icons.help;
      case 'translate':
        return Icons.translate;
      case 'summarize':
        return Icons.summarize;
      case 'code':
      case 'code_help':
        return Icons.code;
      case 'email':
      case 'mail':
        return Icons.email;
      case 'write':
        return Icons.edit;
      case 'send':
        return Icons.send;
      case 'save':
        return Icons.save;
      default:
        return Icons.analytics; // Default fallback icon
    }
  }
}
