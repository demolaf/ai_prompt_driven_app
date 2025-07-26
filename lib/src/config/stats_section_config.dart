import 'package:equatable/equatable.dart';

class StatsSectionConfig extends Equatable {
  factory StatsSectionConfig.fromJson(Map<String, dynamic> json) {
    return StatsSectionConfig(
      conversationsValue: json['conversationsValue'] ?? '0',
      daysActiveValue: json['daysActiveValue'] ?? '0',
      wordsGeneratedValue: json['wordsGeneratedValue'] ?? '0',
      conversationsLabel: json['conversationsLabel'] ?? 'Conversations',
      daysActiveLabel: json['daysActiveLabel'] ?? 'Days Active',
      wordsGeneratedLabel: json['wordsGeneratedLabel'] ?? 'Words Generated',
      backgroundColor: json['backgroundColor'] as String?,
      padding: json['padding']?.toDouble(),
      borderRadius: json['borderRadius']?.toDouble(),
      visible: json['visible'] ?? true,
    );
  }
  const StatsSectionConfig({
    required this.conversationsValue,
    required this.daysActiveValue,
    required this.wordsGeneratedValue,
    this.conversationsLabel = 'Conversations',
    this.daysActiveLabel = 'Days Active',
    this.wordsGeneratedLabel = 'Words Generated',
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.visible = true,
  });

  final String conversationsValue;
  final String daysActiveValue;
  final String wordsGeneratedValue;
  final String conversationsLabel;
  final String daysActiveLabel;
  final String wordsGeneratedLabel;
  final String? backgroundColor;
  final double? padding;
  final double? borderRadius;
  final bool visible;

  @override
  List<Object?> get props => [
    conversationsValue,
    daysActiveValue,
    wordsGeneratedValue,
    conversationsLabel,
    daysActiveLabel,
    wordsGeneratedLabel,
    backgroundColor,
    padding,
    borderRadius,
    visible,
  ];

  Map<String, dynamic> toJson() => {
    'conversationsValue': conversationsValue,
    'daysActiveValue': daysActiveValue,
    'wordsGeneratedValue': wordsGeneratedValue,
    'conversationsLabel': conversationsLabel,
    'daysActiveLabel': daysActiveLabel,
    'wordsGeneratedLabel': wordsGeneratedLabel,
    'backgroundColor': backgroundColor,
    'padding': padding,
    'borderRadius': borderRadius,
    'visible': visible,
  };

  static Map<String, dynamic> get schema {
    return {
      'conversationsValue': '1,247',
      'daysActiveValue': '35',
      'wordsGeneratedValue': '2.4k',
      'conversationsLabel': 'Conversations',
      'daysActiveLabel': 'Days Active',
      'wordsGeneratedLabel': 'Words Generated',
      'backgroundColor': 'FFEEEEEE',
      'padding': 20.0,
      'borderRadius': 12.0,
      'visible': true,
    };
  }
}
