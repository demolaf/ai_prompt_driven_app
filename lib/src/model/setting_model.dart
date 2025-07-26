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
  final String icon; // Icon name as string (e.g., 'moon', 'settings', 'bell')
  final SettingType type;
  final bool? value;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onTap;

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    String iconString;
    final iconData = json['icon'];

    if (iconData is Map<String, dynamic>) {
      // New format: convert back to string representation for SettingModel
      // Create a descriptive string from the codePoint
      iconString = 'icon_${iconData['codePoint'].toRadixString(16)}';
    } else if (iconData is String) {
      // Legacy string format
      iconString = iconData;
    } else {
      // Fallback for any other type
      iconString = 'settings';
    }

    return SettingModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      icon: iconString,
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
      'icon': icon,
      'type': type.name,
      'value': value,
    };
  }

  SettingModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? icon,
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
      id: '1',
      title: 'Dark Mode',
      subtitle: 'Use dark theme',
      icon: 'moon',
      type: SettingType.toggle,
      value: false,
    ),
  ];
}
