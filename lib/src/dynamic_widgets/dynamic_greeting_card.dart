import 'package:ai_prompt_driven_app/src/model/greeting_model.dart';
import 'package:ai_prompt_driven_app/src/model/greeting_card_config.dart';
import 'package:flutter/material.dart';

class DynamicGreetingCard extends StatelessWidget {
  const DynamicGreetingCard({
    required this.data,
    super.key,
    this.isLastItem = false,
    this.config,
  });

  final GreetingModel data;
  final bool isLastItem;
  final GreetingCardConfig? config;

  @override
  Widget build(BuildContext context) {
    // Use config values or fallback to simple defaults
    final gradientColors = config?.gradientColors ?? [Colors.grey.shade400, Colors.grey.shade600];
    final borderRadius = config?.borderRadius ?? 8.0;
    final textColor = config?.textColor ?? Colors.black87;
    final greetingFontSize = config?.greetingFontSize ?? 18.0;
    final questionFontSize = config?.questionFontSize ?? 14.0;
    final languageFontSize = config?.languageFontSize ?? 10.0;
    final padding = config?.padding ?? const EdgeInsets.all(12);
    final margin = config?.margin ?? EdgeInsets.only(right: isLastItem ? 0 : 8);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: config?.shadowColor != null
            ? [
                BoxShadow(
                  color: config!.shadowColor!,
                  blurRadius: config?.shadowBlurRadius ?? 4.0,
                  offset: config?.shadowOffset ?? const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.greeting,
                style: TextStyle(
                  fontSize: greetingFontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                data.question,
                style: TextStyle(
                  fontSize: questionFontSize,
                  color: textColor.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                data.language,
                style: TextStyle(
                  fontSize: languageFontSize,
                  color: textColor.withValues(alpha: 0.6),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}