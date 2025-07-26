import 'package:ai_prompt_driven_app/src/config/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/config/greeting_card_config.dart';
import 'package:ai_prompt_driven_app/src/config/quick_action_config.dart';
import 'package:ai_prompt_driven_app/src/config/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/config/stat_card_config.dart';
import 'package:ai_prompt_driven_app/src/model/greeting.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeViewConfigurable extends Equatable implements ViewConfigurable {
  const HomeViewConfigurable({
    this.scaffoldConfig,
    this.appBarConfig,
    this.statCard1,
    this.statCard2,
    this.greetingCardConfig,
    this.quickActionConfig,
  });

  HomeViewConfigurable.initial()
    : this(
        scaffoldConfig: ScaffoldConfig(backgroundColor: 'FFFFFFFF'),
        appBarConfig: AppBarConfig(title: 'Home'),
        statCard1: StatCardConfig(
          title: 'Total Conversations',
          value: '1,247',
          icon: 'chat_bubble_2',
        ),
        statCard2: StatCardConfig(
          title: 'Languages Supported',
          value: '95+',
          icon: 'globe',
        ),
        greetingCardConfig: GreetingCardConfig(
          gradientColors: [Colors.blue.shade300, Colors.purple.shade300],
          borderRadius: 12.0,
          textColor: Colors.white,
          greetingFontSize: 24.0,
          questionFontSize: 16.0,
          languageFontSize: 12.0,
          padding: const EdgeInsets.all(16),
          greetingsList: GreetingModel.getPlaceholderData,
        ),
        quickActionConfig: QuickActionConfig(
          title: 'Quick Actions',
          titleFontSize: 18.0,
          titleFontWeight: FontWeight.w600,
          layout: QuickActionLayout.grid,
          spacing: 12.0,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          crossAxisCount: 2,
          childAspectRatio: 3.0,
          actions: QuickActionConfig.defaultActions,
        ),
      );

  factory HomeViewConfigurable.fromJson(Map<String, dynamic> json) {
    return HomeViewConfigurable(
      scaffoldConfig: json['scaffoldConfig'] != null
          ? ScaffoldConfig.fromJson(json['scaffoldConfig'])
          : null,
      appBarConfig: json['appBarConfig'] != null
          ? AppBarConfig.fromJson(json['appBarConfig'])
          : null,
      statCard1: json['statCard1'] != null
          ? StatCardConfig.fromJson(json['statCard1'])
          : null,
      statCard2: json['statCard2'] != null
          ? StatCardConfig.fromJson(json['statCard2'])
          : null,
      greetingCardConfig: json['greetingCardConfig'] != null
          ? GreetingCardConfig.fromJson(json['greetingCardConfig'])
          : null,
      quickActionConfig: json['quickActionConfig'] != null
          ? QuickActionConfig.fromJson(json['quickActionConfig'])
          : null,
    );
  }

  final ScaffoldConfig? scaffoldConfig;
  final AppBarConfig? appBarConfig;
  final StatCardConfig? statCard1;
  final StatCardConfig? statCard2;
  final GreetingCardConfig? greetingCardConfig;
  final QuickActionConfig? quickActionConfig;

  @override
  Map<String, dynamic> toJson() => {
    'scaffoldConfig': scaffoldConfig?.toJson(),
    'appBarConfig': appBarConfig?.toJson(),
    'statCard1': statCard1?.toJson(),
    'statCard2': statCard2?.toJson(),
    'greetingCardConfig': greetingCardConfig?.toJson(),
    'quickActionConfig': quickActionConfig?.toJson(),
  };

  static Map<String, dynamic> get schema {
    return {
      'scaffoldConfig': ScaffoldConfig.schema,
      'appBarConfig': AppBarConfig.schema,
      'statCard1': StatCardConfig.schema,
      'statCard2': StatCardConfig.schema,
      'greetingCardConfig': GreetingCardConfig.schema,
      'quickActionConfig': QuickActionConfig.schema,
    };
  }

  @override
  HomeViewConfigurable merge(Map<String, dynamic>? updates) {
    final currentJson = toJson();
    final mergedJson = _deepMerge(currentJson, updates);
    return HomeViewConfigurable.fromJson(mergedJson);
  }

  Map<String, dynamic> _deepMerge(
    Map<String, dynamic>? current,
    Map<String, dynamic>? updates,
  ) {
    final result = Map<String, dynamic>.from(current ?? {});

    (updates ?? {}).forEach((key, value) {
      if (value is Map<String, dynamic> &&
          result[key] is Map<String, dynamic>) {
        result[key] = _deepMerge(result[key] as Map<String, dynamic>, value);
      } else if (value != null) {
        result[key] = value;
      }
    });

    return result;
  }

  @override
  List<Object?> get props => [
    scaffoldConfig,
    appBarConfig,
    statCard1,
    statCard2,
    greetingCardConfig,
    quickActionConfig,
  ];
}
