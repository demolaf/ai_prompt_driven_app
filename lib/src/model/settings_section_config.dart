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
                .map(
                  (setting) =>
                      SettingModel.fromJson(setting as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (titleFontSize != null) 'titleFontSize': titleFontSize,
      if (titleColor != null) 'titleColor': titleColor!.toARGB32(),
      if (titleFontWeight != null)
        'titleFontWeight': _getStringFromFontWeight(titleFontWeight!),
      if (spacing != null) 'spacing': spacing,
      if (settings != null)
        'settings': settings!.map((setting) => setting.toJson()).toList(),
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
      'title': {'type': 'string', 'description': 'Section title text'},
      'titleFontSize': {
        'type': 'number',
        'description': 'Font size for the section title',
      },
      'titleColor': {
        'type': 'integer',
        'description': 'Color value for the section title',
      },
      'titleFontWeight': {
        'type': 'string',
        'enum': [
          'w100',
          'w200',
          'w300',
          'w400',
          'w500',
          'w600',
          'w700',
          'w800',
          'w900',
          'normal',
          'bold',
          'semibold',
        ],
        'description': 'Font weight for the section title',
      },
      'spacing': {
        'type': 'number',
        'description': 'Spacing between title and settings list',
      },
      'settings': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'id': {
              'type': 'string',
              'description': 'Unique identifier for the setting',
            },
            'title': {'type': 'string', 'description': 'Setting title text'},
            'subtitle': {
              'type': 'string',
              'description': 'Setting subtitle/description text',
            },
            'icon': {
              'type': 'object',
              'properties': {
                'codePoint': {
                  'type': 'integer',
                  'description': '''Icon codePoint from Flutter libraries. Common examples:
                  
Material Icons (fontFamily: '', fontPackage: ''):
- 0xe57c - Settings icon
- 0xe7f4 - Notifications icon  
- 0xe32a - Dark mode icon
- 0xe8f4 - Language icon
- 0xe8f5 - Location icon
- 0xe86c - Privacy icon
- 0xe8b8 - Security icon
- 0xe0c3 - Account icon
- 0xe8dd - Help icon
- 0xe8f0 - Info icon

Cupertino Icons (fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'):
- 0xf2ca - Settings icon
- 0xf3e2 - Bell icon  
- 0xf4b3 - Moon icon
- 0xf2e7 - Globe icon
- 0xf455 - Location icon
- 0xf4c9 - Lock shield icon
- 0xf4d0 - Person icon
- 0xf3f0 - Question circle icon
- 0xf3ec - Info circle icon''',
                },
                'fontFamily': {
                  'type': 'string',
                  'description': '''Font family for the icon:
- '' (empty string) for Material Icons
- 'CupertinoIcons' for Cupertino Icons
- Other font families as needed''',
                },
                'fontPackage': {
                  'type': 'string',
                  'description': '''Font package for the icon:
- '' (empty string) for Material Icons  
- 'cupertino_icons' for Cupertino Icons
- Other packages as needed''',
                },
              },
              'required': ['codePoint'],
              'description': '''Icon data for the setting. Use Flutter's built-in icon libraries:
              
Examples:
- Material settings: {"codePoint": 57724, "fontFamily": "", "fontPackage": ""}
- Cupertino bell: {"codePoint": 62434, "fontFamily": "CupertinoIcons", "fontPackage": "cupertino_icons"}
- Cupertino moon: {"codePoint": 62643, "fontFamily": "CupertinoIcons", "fontPackage": "cupertino_icons"}''',
            },
            'type': {
              'type': 'string',
              'enum': ['toggle', 'navigation', 'action'],
              'description': 'Type of setting interaction',
            },
            'value': {
              'type': 'boolean',
              'description': 'Current value for toggle settings',
            },
          },
          'required': ['id', 'title', 'subtitle', 'icon', 'type'],
        },
        'description': 'List of settings to display',
      },
    },
  };
}
