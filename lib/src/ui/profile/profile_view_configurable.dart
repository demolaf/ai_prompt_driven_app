import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';

class ProfileViewConfigurable extends ViewConfigurable {
  ProfileViewConfigurable({
    required this.scaffoldConfig,
    required this.appBarConfig,
    this.darkModeEnabled = false,
    this.userName,
    this.userEmail,
  });

  ProfileViewConfigurable.fromJson(Map<String, dynamic> json)
      : scaffoldConfig = ScaffoldConfig.fromJson(json['scaffoldConfig'] ?? {}),
        appBarConfig = AppBarConfig.fromJson(json['appBarConfig'] ?? {}),
        darkModeEnabled = json['darkModeEnabled'] ?? false,
        userName = json['userName'],
        userEmail = json['userEmail'];

  final ScaffoldConfig scaffoldConfig;
  final AppBarConfig appBarConfig;
  final bool darkModeEnabled;
  final String? userName;
  final String? userEmail;

  @override
  Map<String, dynamic> toJson() {
    return {
      'scaffoldConfig': scaffoldConfig.toJson(),
      'appBarConfig': appBarConfig.toJson(),
      'darkModeEnabled': darkModeEnabled,
      'userName': userName,
      'userEmail': userEmail,
    };
  }

  @override
  ProfileViewConfigurable merge(Map<String, dynamic> updates) {
    final currentJson = toJson();
    final mergedJson = _deepMerge(currentJson, updates);
    return ProfileViewConfigurable.fromJson(mergedJson);
  }

  Map<String, dynamic> _deepMerge(
    Map<String, dynamic> current,
    Map<String, dynamic> updates,
  ) {
    final result = Map<String, dynamic>.from(current);

    updates.forEach((key, value) {
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