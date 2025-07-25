import 'package:flutter/material.dart';
import 'package:ai_prompt_driven_app/src/model/greeting_model.dart';

class GreetingCardConfig {
  const GreetingCardConfig({
    this.gradientColors,
    this.borderRadius,
    this.textColor,
    this.greetingFontSize,
    this.questionFontSize,
    this.languageFontSize,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowOffset,
    this.padding,
    this.margin,
    this.greetingsList,
  });

  final List<Color>? gradientColors;
  final double? borderRadius;
  final Color? textColor;
  final double? greetingFontSize;
  final double? questionFontSize;
  final double? languageFontSize;
  final Color? shadowColor;
  final double? shadowBlurRadius;
  final Offset? shadowOffset;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final List<GreetingModel>? greetingsList;

  factory GreetingCardConfig.fromJson(Map<String, dynamic> json) {
    return GreetingCardConfig(
      gradientColors: json['gradientColors'] != null
          ? (json['gradientColors'] as List<dynamic>)
                .map((color) => Color(color as int))
                .toList()
          : null,
      borderRadius: json['borderRadius']?.toDouble(),
      textColor: json['textColor'] != null ? Color(json['textColor']) : null,
      greetingFontSize: json['greetingFontSize']?.toDouble(),
      questionFontSize: json['questionFontSize']?.toDouble(),
      languageFontSize: json['languageFontSize']?.toDouble(),
      shadowColor: json['shadowColor'] != null
          ? Color(json['shadowColor'])
          : null,
      shadowBlurRadius: json['shadowBlurRadius']?.toDouble(),
      shadowOffset: json['shadowOffset'] != null
          ? Offset(
              json['shadowOffset']['dx']?.toDouble() ?? 0,
              json['shadowOffset']['dy']?.toDouble() ?? 0,
            )
          : null,
      padding: json['padding'] != null
          ? EdgeInsets.fromLTRB(
              json['padding']['left']?.toDouble() ?? 0,
              json['padding']['top']?.toDouble() ?? 0,
              json['padding']['right']?.toDouble() ?? 0,
              json['padding']['bottom']?.toDouble() ?? 0,
            )
          : null,
      margin: json['margin'] != null
          ? EdgeInsets.fromLTRB(
              json['margin']['left']?.toDouble() ?? 0,
              json['margin']['top']?.toDouble() ?? 0,
              json['margin']['right']?.toDouble() ?? 0,
              json['margin']['bottom']?.toDouble() ?? 0,
            )
          : null,
      greetingsList: json['greetingsList'] != null
          ? (json['greetingsList'] as List<dynamic>)
                .map(
                  (greeting) =>
                      GreetingModel.fromJson(greeting as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (gradientColors != null)
        'gradientColors': gradientColors!
            .map((color) => color.toARGB32())
            .toList(),
      if (borderRadius != null) 'borderRadius': borderRadius,
      if (textColor != null) 'textColor': textColor!.toARGB32(),
      if (greetingFontSize != null) 'greetingFontSize': greetingFontSize,
      if (questionFontSize != null) 'questionFontSize': questionFontSize,
      if (languageFontSize != null) 'languageFontSize': languageFontSize,
      if (shadowColor != null) 'shadowColor': shadowColor!.toARGB32(),
      if (shadowBlurRadius != null) 'shadowBlurRadius': shadowBlurRadius,
      if (shadowOffset != null)
        'shadowOffset': {'dx': shadowOffset!.dx, 'dy': shadowOffset!.dy},
      if (padding != null)
        'padding': {
          'left': padding!.left,
          'top': padding!.top,
          'right': padding!.right,
          'bottom': padding!.bottom,
        },
      if (margin != null)
        'margin': {
          'left': margin!.left,
          'top': margin!.top,
          'right': margin!.right,
          'bottom': margin!.bottom,
        },
      if (greetingsList != null)
        'greetingsList': greetingsList!
            .map((greeting) => greeting.toJson())
            .toList(),
    };
  }

  static Map<String, dynamic> get schema => {
    'type': 'object',
    'properties': {
      'gradientColors': {
        'type': 'array',
        'items': {'type': 'integer'},
        'description': 'List of color values for gradient background',
      },
      'borderRadius': {
        'type': 'number',
        'description': 'Border radius for card corners',
      },
      'textColor': {
        'type': 'integer',
        'description': 'Primary text color value',
      },
      'greetingFontSize': {
        'type': 'number',
        'description': 'Font size for greeting text',
      },
      'questionFontSize': {
        'type': 'number',
        'description': 'Font size for question text',
      },
      'languageFontSize': {
        'type': 'number',
        'description': 'Font size for language text',
      },
      'shadowColor': {'type': 'integer', 'description': 'Shadow color value'},
      'shadowBlurRadius': {
        'type': 'number',
        'description': 'Shadow blur radius',
      },
      'shadowOffset': {
        'type': 'object',
        'properties': {
          'dx': {'type': 'number'},
          'dy': {'type': 'number'},
        },
        'description': 'Shadow offset',
      },
      'padding': {
        'type': 'object',
        'properties': {
          'left': {'type': 'number'},
          'top': {'type': 'number'},
          'right': {'type': 'number'},
          'bottom': {'type': 'number'},
        },
        'description': 'Internal padding',
      },
      'margin': {
        'type': 'object',
        'properties': {
          'left': {'type': 'number'},
          'top': {'type': 'number'},
          'right': {'type': 'number'},
          'bottom': {'type': 'number'},
        },
        'description': 'External margin',
      },
      'greetingsList': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'greeting': {
              'type': 'string',
              'description': 'The greeting text in the specified language',
            },
            'question': {
              'type': 'string',
              'description': 'A question in the specified language',
            },
            'language': {
              'type': 'string',
              'description': 'The name of the language',
            },
          },
          'required': ['greeting', 'question', 'language'],
        },
        'description': 'List of greetings to display in the cards',
      },
    },
  };
}
