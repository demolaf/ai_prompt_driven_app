import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:equatable/equatable.dart';

class ProfileViewConfigurable extends Equatable implements ViewConfigurable {
  const ProfileViewConfigurable({this.scaffoldConfig, this.appBarConfig});

  factory ProfileViewConfigurable.fromJson(Map<String, dynamic> json) {
    return ProfileViewConfigurable(
      scaffoldConfig: json['scaffoldConfig'] != null
          ? ScaffoldConfig.fromJson(json['scaffoldConfig'])
          : null,
      appBarConfig: json['appBarConfig'] != null
          ? AppBarConfig.fromJson(json['appBarConfig'])
          : null,
    );
  }

  final ScaffoldConfig? scaffoldConfig;
  final AppBarConfig? appBarConfig;

  @override
  List<Object?> get props => [scaffoldConfig, appBarConfig];

  @override
  Map<String, dynamic> toJson() {
    return {
      'scaffoldConfig': scaffoldConfig?.toJson(),
      'appBarConfig': appBarConfig?.toJson(),
    };
  }

  static Map<String, dynamic> get schema {
    return {
      'scaffoldConfig': ScaffoldConfig.schema,
      'appBarConfig': AppBarConfig.schema,
    };
  }

  @override
  ProfileViewConfigurable merge(Map<String, dynamic>? updates) {
    final currentJson = toJson();
    final mergedJson = _deepMerge(currentJson, updates);
    return ProfileViewConfigurable.fromJson(mergedJson);
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
