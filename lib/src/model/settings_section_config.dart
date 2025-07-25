import 'package:ai_prompt_driven_app/src/model/setting_model.dart';
import 'package:flutter/cupertino.dart';

class SettingsSectionConfig {
  const SettingsSectionConfig({
    this.title,
    this.titleFontSize,
    this.titleColor,
    this.titleFontWeight,
    this.spacing,
    this.settings,
  });

  final String? title;
  final double? titleFontSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final double? spacing;
  final List<SettingModel>? settings;

  factory SettingsSectionConfig.fromJson(Map<String, dynamic> json) {
    return SettingsSectionConfig(
      title: json['title'] as String?,
      titleFontSize: json['titleFontSize']?.toDouble(),
      titleColor: json['titleColor'] != null ? Color(json['titleColor']) : null,
      titleFontWeight: json['titleFontWeight'] != null
          ? _getFontWeightFromString(json['titleFontWeight'] as String)
          : null,
      spacing: json['spacing']?.toDouble(),
      settings: json['settings'] != null
          ? (json['settings'] as List<dynamic>)
              .map((setting) => SettingModel.fromJson(setting as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (titleFontSize != null) 'titleFontSize': titleFontSize,
      if (titleColor != null) 'titleColor': titleColor!.value,
      if (titleFontWeight != null) 'titleFontWeight': _getStringFromFontWeight(titleFontWeight!),
      if (spacing != null) 'spacing': spacing,
      if (settings != null) 'settings': settings!.map((setting) => setting.toJson()).toList(),
    };
  }

  SettingsSectionConfig copyWith({
    String? title,
    double? titleFontSize,
    Color? titleColor,
    FontWeight? titleFontWeight,
    double? spacing,
    List<SettingModel>? settings,
  }) {
    return SettingsSectionConfig(
      title: title ?? this.title,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleColor: titleColor ?? this.titleColor,
      titleFontWeight: titleFontWeight ?? this.titleFontWeight,
      spacing: spacing ?? this.spacing,
      settings: settings ?? this.settings,
    );
  }

  static FontWeight _getFontWeightFromString(String fontWeight) {
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

  static String _getStringFromFontWeight(FontWeight fontWeight) {
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

  static Map<String, dynamic> get schema => {
    'type': 'object',
    'properties': {
      'title': {
        'type': 'string',
        'description': 'Section title text'
      },
      'titleFontSize': {
        'type': 'number',
        'description': 'Font size for the section title'
      },
      'titleColor': {
        'type': 'integer',
        'description': 'Color value for the section title'
      },
      'titleFontWeight': {
        'type': 'string',
        'enum': ['w100', 'w200', 'w300', 'w400', 'w500', 'w600', 'w700', 'w800', 'w900', 'normal', 'bold', 'semibold'],
        'description': 'Font weight for the section title'
      },
      'spacing': {
        'type': 'number',
        'description': 'Spacing between title and settings list'
      },
      'settings': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'id': {
              'type': 'string',
              'description': 'Unique identifier for the setting'
            },
            'title': {
              'type': 'string',
              'description': 'Setting title text'
            },
            'subtitle': {
              'type': 'string',
              'description': 'Setting subtitle/description text'
            },
            'icon': {
              'type': 'object',
              'properties': {
                'codePoint': {
                  'type': 'integer',
                  'description': 'Icon codePoint (e.g., 0xF4B3 for moon)'
                },
                'fontFamily': {
                  'type': 'string',
                  'description': 'Font family for the icon (empty for default)'
                },
                'fontPackage': {
                  'type': 'string',
                  'description': 'Font package for the icon (empty for default)'
                }
              },
              'required': ['codePoint'],
              'description': 'Icon data for the setting'
            },
            'type': {
              'type': 'string',
              'enum': ['toggle', 'navigation', 'action'],
              'description': 'Type of setting interaction'
            },
            'value': {
              'type': 'boolean',
              'description': 'Current value for toggle settings'
            }
          },
          'required': ['id', 'title', 'subtitle', 'icon', 'type']
        },
        'description': 'List of settings to display'
      }
    }
  };
}