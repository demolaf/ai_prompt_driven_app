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

  /// Parses a font weight string to FontWeight
  static FontWeight parseFontWeight(String fontWeight) {
    switch (fontWeight) {
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
      case 'normal':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
      case 'semibold':
        return FontWeight.w600;
      case 'w700':
      case 'bold':
        return FontWeight.w700;
      case 'w800':
        return FontWeight.w800;
      case 'w900':
        return FontWeight.w900;
      default:
        return FontWeight.w600;
    }
  }

  /// Converts a FontWeight to string representation
  static String fontWeightToString(FontWeight fontWeight) {
    switch (fontWeight) {
      case FontWeight.w100:
        return 'w100';
      case FontWeight.w200:
        return 'w200';
      case FontWeight.w300:
        return 'w300';
      case FontWeight.w400:
        return 'w400';
      case FontWeight.w500:
        return 'w500';
      case FontWeight.w600:
        return 'w600';
      case FontWeight.w700:
        return 'w700';
      case FontWeight.w800:
        return 'w800';
      case FontWeight.w900:
        return 'w900';
      default:
        return 'w600';
    }
  }

  /// Parses a color from JSON with null safety
  static Color? parseColorFromJson(dynamic colorValue) {
    if (colorValue == null) return null;
    if (colorValue is int) return Color(colorValue);
    return parseColor(colorValue);
  }

  /// Converts a Color to int representation for JSON
  static int colorToInt(Color color) {
    return color.toARGB32();
  }

  /// Parses a double from JSON with null safety
  static double? parseDoubleFromJson(dynamic value) {
    return value?.toDouble();
  }
}
