import 'package:equatable/equatable.dart';

class StatCardConfig extends Equatable {
  const StatCardConfig({
    required this.title,
    required this.value,
    this.icon,
    this.backgroundColor,
    this.titleColor,
    this.valueColor,
    this.iconColor,
    this.padding,
    this.borderRadius,
    this.visible = true,
  });

  final String title;
  final String value;
  final String? icon; // Icon name as string (e.g., 'star', 'home', 'person')
  final String? backgroundColor;
  final String? titleColor;
  final String? valueColor;
  final String? iconColor;
  final double? padding;
  final double? borderRadius;
  final bool visible;

  @override
  List<Object?> get props => [
    title,
    value,
    icon,
    backgroundColor,
    titleColor,
    valueColor,
    iconColor,
    padding,
    borderRadius,
    visible,
  ];

  Map<String, dynamic> toJson() => {
    'title': title,
    'value': value,
    'icon': icon,
    'backgroundColor': backgroundColor,
    'titleColor': titleColor,
    'valueColor': valueColor,
    'iconColor': iconColor,
    'padding': padding,
    'borderRadius': borderRadius,
    'visible': visible,
  };

  factory StatCardConfig.fromJson(Map<String, dynamic> json) {
    String? iconString;
    final iconData = json['icon'];

    if (iconData is Map<String, dynamic>) {
      // New format: convert back to string representation for StatCard
      // For now, we'll use a placeholder or extract meaningful info
      iconString = 'icon_${iconData['codePoint'].toRadixString(16)}';
    } else if (iconData is String) {
      // Legacy string format
      iconString = iconData;
    }

    return StatCardConfig(
      title: json['title'] ?? '',
      value: json['value'] ?? '',
      icon: iconString,
      backgroundColor: json['backgroundColor'] as String?,
      titleColor: json['titleColor'] as String?,
      valueColor: json['valueColor'] as String?,
      iconColor: json['iconColor'] as String?,
      padding: json['padding']?.toDouble(),
      borderRadius: json['borderRadius']?.toDouble(),
      visible: json['visible'] ?? true,
    );
  }

  StatCardConfig copyWith({
    String? title,
    String? value,
    String? icon,
    String? backgroundColor,
    String? titleColor,
    String? valueColor,
    String? iconColor,
    double? padding,
    double? borderRadius,
    bool? visible,
  }) => StatCardConfig(
    title: title ?? this.title,
    value: value ?? this.value,
    icon: icon ?? this.icon,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    titleColor: titleColor ?? this.titleColor,
    valueColor: valueColor ?? this.valueColor,
    iconColor: iconColor ?? this.iconColor,
    padding: padding ?? this.padding,
    borderRadius: borderRadius ?? this.borderRadius,
    visible: visible ?? this.visible,
  );

  static Map<String, dynamic> get schema {
    return {
      'title': 'Total Sales', // Example: card title text
      'value': '1,234', // Example: main value to display
      'icon': 'trending_up', // Example: icon name (optional)
      'backgroundColor': 'FFEEEEEE', // Example: background color (optional)
      'titleColor': 'FF666666', // Example: title text color (optional)
      'valueColor': 'FF000000', // Example: value text color (optional)
      'iconColor': 'FF0066CC', // Example: icon color (optional)
      'padding': 16.0, // Example: padding value (optional)
      'borderRadius': 12.0, // Example: border radius (optional)
      'visible': true, // Example: visibility boolean (optional)
    };
  }
}
