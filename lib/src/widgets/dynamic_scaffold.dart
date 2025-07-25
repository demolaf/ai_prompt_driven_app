import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:flutter/material.dart';

class DynamicScaffold extends Scaffold {
  const DynamicScaffold({
    super.key,
    super.body,
    super.floatingActionButton,
    this.config,
  });

  final ScaffoldConfig? config;

  @override
  Color? get backgroundColor {
    return _parseColor(config?.backgroundColor);
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
}
