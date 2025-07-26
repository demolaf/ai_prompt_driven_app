import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';

enum QuickActionLayout { grid, list }

class QuickActionItem {
  factory QuickActionItem.fromJson(Map<String, dynamic> json) {
    return QuickActionItem(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
      color: WidgetParser.parseColorFromJson(json['color']),
      backgroundColor: WidgetParser.parseColorFromJson(json['backgroundColor']),
    );
  }
  const QuickActionItem({
    required this.id,
    required this.title,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  final String id;
  final String title;
  final String icon; // Icon name as string
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      if (color != null) 'color': WidgetParser.colorToInt(color!),
      if (backgroundColor != null)
        'backgroundColor': WidgetParser.colorToInt(backgroundColor!),
    };
  }
}

class QuickActionConfig {
  factory QuickActionConfig.fromJson(Map<String, dynamic> json) {
    return QuickActionConfig(
      title: json['title'] as String?,
      titleFontSize: json['titleFontSize']?.toDouble(),
      titleColor: WidgetParser.parseColorFromJson(json['titleColor']),
      titleFontWeight: json['titleFontWeight'] != null
          ? WidgetParser.parseFontWeight(json['titleFontWeight'] as String)
          : null,
      layout: json['layout'] != null
          ? QuickActionLayout.values.firstWhere(
              (e) => e.name == json['layout'],
              orElse: () => QuickActionLayout.grid,
            )
          : QuickActionLayout.grid,
      spacing: json['spacing']?.toDouble(),
      crossAxisSpacing: json['crossAxisSpacing']?.toDouble(),
      mainAxisSpacing: json['mainAxisSpacing']?.toDouble(),
      crossAxisCount: json['crossAxisCount'] as int?,
      childAspectRatio: json['childAspectRatio']?.toDouble(),
      actions: json['actions'] != null
          ? (json['actions'] as List<dynamic>)
                .map(
                  (action) =>
                      QuickActionItem.fromJson(action as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }
  const QuickActionConfig({
    this.title,
    this.titleFontSize,
    this.titleColor,
    this.titleFontWeight,
    this.layout = QuickActionLayout.grid,
    this.spacing,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.crossAxisCount,
    this.childAspectRatio,
    this.actions,
  });

  final String? title;
  final double? titleFontSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final QuickActionLayout layout;
  final double? spacing;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final List<QuickActionItem>? actions;

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (titleFontSize != null) 'titleFontSize': titleFontSize,
      if (titleColor != null)
        'titleColor': WidgetParser.colorToInt(titleColor!),
      if (titleFontWeight != null)
        'titleFontWeight': WidgetParser.fontWeightToString(titleFontWeight!),
      'layout': layout.name,
      if (spacing != null) 'spacing': spacing,
      if (crossAxisSpacing != null) 'crossAxisSpacing': crossAxisSpacing,
      if (mainAxisSpacing != null) 'mainAxisSpacing': mainAxisSpacing,
      if (crossAxisCount != null) 'crossAxisCount': crossAxisCount,
      if (childAspectRatio != null) 'childAspectRatio': childAspectRatio,
      if (actions != null)
        'actions': actions!.map((action) => action.toJson()).toList(),
    };
  }

  QuickActionConfig copyWith({
    String? title,
    double? titleFontSize,
    Color? titleColor,
    FontWeight? titleFontWeight,
    QuickActionLayout? layout,
    double? spacing,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    int? crossAxisCount,
    double? childAspectRatio,
    List<QuickActionItem>? actions,
  }) {
    return QuickActionConfig(
      title: title ?? this.title,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleColor: titleColor ?? this.titleColor,
      titleFontWeight: titleFontWeight ?? this.titleFontWeight,
      layout: layout ?? this.layout,
      spacing: spacing ?? this.spacing,
      crossAxisSpacing: crossAxisSpacing ?? this.crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing ?? this.mainAxisSpacing,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      childAspectRatio: childAspectRatio ?? this.childAspectRatio,
      actions: actions ?? this.actions,
    );
  }

  static List<QuickActionItem> get defaultActions => [
    QuickActionItem(id: 'translate', title: 'Translate', icon: 'translate'),
    QuickActionItem(id: 'summarize', title: 'Summarize', icon: 'summarize'),
    QuickActionItem(id: 'code_help', title: 'Code Help', icon: 'code'),
    QuickActionItem(id: 'write_email', title: 'Write Email', icon: 'email'),
  ];

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
      'layout': {
        'type': 'string',
        'enum': ['grid', 'list'],
        'description': 'Layout type: grid (2 columns) or list (single column)',
      },
      'spacing': {
        'type': 'number',
        'description': 'Spacing between title and actions',
      },
      'crossAxisSpacing': {
        'type': 'number',
        'description': 'Horizontal spacing between grid items',
      },
      'mainAxisSpacing': {
        'type': 'number',
        'description': 'Vertical spacing between grid items',
      },
      'crossAxisCount': {
        'type': 'integer',
        'description': 'Number of columns in grid layout (default: 2)',
      },
      'childAspectRatio': {
        'type': 'number',
        'description': 'Aspect ratio for grid items (default: 3)',
      },
      'actions': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'id': {
              'type': 'string',
              'description': 'Unique identifier for the action',
            },
            'title': {'type': 'string', 'description': 'Action title text'},
            'icon': {
              'type': 'string',
              'description': '''Icon name as string. Common examples:
              
- 'globe' - Translation/language icon
- 'info' - Information/summary icon  
- 'star' - Favorite/important icon
- 'person' - User/profile icon
- 'settings' - Settings/config icon
- 'help' - Help/support icon
- 'download' - Download icon
- 'upload' - Upload icon''',
            },
            'color': {
              'type': 'integer',
              'description': 'Icon and text color value',
            },
            'backgroundColor': {
              'type': 'integer',
              'description': 'Background color value for the action',
            },
          },
          'required': ['id', 'title', 'icon'],
        },
        'description': 'List of quick actions to display',
      },
    },
  };
}
