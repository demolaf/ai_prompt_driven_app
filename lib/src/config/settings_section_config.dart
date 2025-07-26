import 'package:ai_prompt_driven_app/src/model/setting.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';
import 'package:flutter/cupertino.dart';

class SettingsSectionConfig {
  factory SettingsSectionConfig.fromJson(Map<String, dynamic> json) {
    return SettingsSectionConfig(
      title: json['title'] as String?,
      titleFontSize: json['titleFontSize']?.toDouble(),
      titleColor: WidgetParser.parseColorFromJson(json['titleColor']),
      titleFontWeight: json['titleFontWeight'] != null
          ? WidgetParser.parseFontWeight(json['titleFontWeight'] as String)
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

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (titleFontSize != null) 'titleFontSize': titleFontSize,
      if (titleColor != null) 'titleColor': WidgetParser.colorToInt(titleColor!),
      if (titleFontWeight != null)
        'titleFontWeight': WidgetParser.fontWeightToString(titleFontWeight!),
      if (spacing != null) 'spacing': spacing,
      if (settings != null)
        'settings': settings!.map((setting) => setting.toJson()).toList(),
    };
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
              'type': 'string',
              'description': '''Icon name as string. Common examples:
              
- 'settings' - Settings icon
- 'notifications' - Notifications bell icon  
- 'moon' - Dark mode/night icon
- 'globe' - Language/global icon
- 'location' - Location pin icon
- 'privacy' - Privacy/lock icon
- 'security' - Security/shield icon
- 'person' - Account/profile icon
- 'help' - Help/question icon
- 'info' - Information icon''',
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
