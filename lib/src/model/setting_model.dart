import 'package:flutter/cupertino.dart';

enum SettingType { toggle, navigation, action }

class SettingModel {
  const SettingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.type,
    this.value,
    this.onToggle,
    this.onTap,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final SettingType type;
  final bool? value;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onTap;

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    final iconData = json['icon'];
    IconData icon;

    if (iconData is Map<String, dynamic>) {
      // New format: {codePoint: 0xF3E2, fontFamily: '', fontPackage: ''}
      icon = IconData(
        iconData['codePoint'] as int,
        fontFamily: iconData['fontFamily']?.isEmpty == true
            ? null
            : iconData['fontFamily'] as String?,
        fontPackage: iconData['fontPackage']?.isEmpty == true
            ? null
            : iconData['fontPackage'] as String?,
      );
    } else {
      // Legacy format: direct integer codePoint
      icon = IconData(
        iconData as int,
        fontFamily: 'CupertinoIcons',
        fontPackage: 'cupertino_icons',
      );
    }

    return SettingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      icon: icon,
      type: SettingType.values.firstWhere(
        (e) => e.name == json['type'] as String,
        orElse: () => SettingType.toggle,
      ),
      value: json['value'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'icon': {
        'codePoint': icon.codePoint,
        'fontFamily': icon.fontFamily ?? '',
        'fontPackage': icon.fontPackage ?? '',
      },
      'type': type.name,
      'value': value,
    };
  }

  SettingModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    IconData? icon,
    SettingType? type,
    bool? value,
    ValueChanged<bool>? onToggle,
    VoidCallback? onTap,
  }) {
    return SettingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      value: value ?? this.value,
      onToggle: onToggle ?? this.onToggle,
      onTap: onTap ?? this.onTap,
    );
  }

  static List<SettingModel> get defaultSettings => [
    SettingModel(
      id: 'dark_mode',
      title: 'Dark Mode',
      subtitle: 'Use dark theme',
      icon: CupertinoIcons.moon,
      type: SettingType.toggle,
      value: false,
    ),
  ];
}
