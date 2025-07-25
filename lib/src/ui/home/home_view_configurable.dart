import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/model/stat_card_config.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:equatable/equatable.dart';

class HomeViewConfigurable extends Equatable implements ViewConfigurable {
  const HomeViewConfigurable({
    this.scaffoldConfig,
    this.appBarConfig,
    this.statCard1,
    this.statCard2,
  });

  final ScaffoldConfig? scaffoldConfig;
  final AppBarConfig? appBarConfig;
  final StatCardConfig? statCard1;
  final StatCardConfig? statCard2;

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
      );

  @override
  List<Object?> get props => [
    scaffoldConfig,
    appBarConfig,
    statCard1,
    statCard2,
  ];

  @override
  Map<String, dynamic> toJson() => {
    'scaffoldConfig': scaffoldConfig?.toJson(),
    'appBarConfig': appBarConfig?.toJson(),
    'statCard1': statCard1?.toJson(),
    'statCard2': statCard2?.toJson(),
  };

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
    );
  }

  HomeViewConfigurable copyWith({
    ScaffoldConfig? scaffoldConfig,
    AppBarConfig? appBarConfig,
    StatCardConfig? statCard1,
    StatCardConfig? statCard2,
  }) {
    return HomeViewConfigurable(
      scaffoldConfig: scaffoldConfig ?? this.scaffoldConfig,
      appBarConfig: appBarConfig ?? this.appBarConfig,
      statCard1: statCard1 ?? this.statCard1,
      statCard2: statCard2 ?? this.statCard2,
    );
  }

  static Map<String, dynamic> get schema {
    return {
      'scaffoldConfig': ScaffoldConfig.schema,
      'appBarConfig': AppBarConfig.schema,
      'statCard1': StatCardConfig.schema,
      'statCard2': StatCardConfig.schema,
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
}
