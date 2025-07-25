import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/model/settings_section_config.dart';
import 'package:ai_prompt_driven_app/src/model/setting_model.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewConfigurable extends Equatable implements ViewConfigurable {
  const ProfileViewConfigurable({
    this.scaffoldConfig,
    this.appBarConfig,
    this.settingsSectionConfig,
  });

  ProfileViewConfigurable.initial()
    : this(
        scaffoldConfig: ScaffoldConfig(backgroundColor: 'FFFFFFFF'),
        appBarConfig: AppBarConfig(title: 'Profile'),
        settingsSectionConfig: SettingsSectionConfig(
          title: 'Settings',
          titleFontSize: 18.0,
          titleColor: CupertinoColors.label,
          titleFontWeight: FontWeight.w600,
          spacing: 16.0,
          settings: SettingModel.defaultSettings,
        ),
      );

  factory ProfileViewConfigurable.fromJson(Map<String, dynamic> json) {
    return ProfileViewConfigurable(
      scaffoldConfig: json['scaffoldConfig'] != null
          ? ScaffoldConfig.fromJson(json['scaffoldConfig'])
          : null,
      appBarConfig: json['appBarConfig'] != null
          ? AppBarConfig.fromJson(json['appBarConfig'])
          : null,
      settingsSectionConfig: json['settingsSectionConfig'] != null
          ? SettingsSectionConfig.fromJson(json['settingsSectionConfig'])
          : null,
    );
  }

  final ScaffoldConfig? scaffoldConfig;
  final AppBarConfig? appBarConfig;
  final SettingsSectionConfig? settingsSectionConfig;

  @override
  List<Object?> get props => [
    scaffoldConfig,
    appBarConfig,
    settingsSectionConfig,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'scaffoldConfig': scaffoldConfig?.toJson(),
      'appBarConfig': appBarConfig?.toJson(),
      'settingsSectionConfig': settingsSectionConfig?.toJson(),
    };
  }

  static Map<String, dynamic> get schema {
    return {
      'scaffoldConfig': ScaffoldConfig.schema,
      'appBarConfig': AppBarConfig.schema,
      'settingsSectionConfig': SettingsSectionConfig.schema,
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
        // Handle special case for settingsSectionConfig
        if (key == 'settingsSectionConfig') {
          result[key] = _mergeSettingsSection(
            result[key] as Map<String, dynamic>,
            value,
          );
        } else {
          result[key] = _deepMerge(result[key] as Map<String, dynamic>, value);
        }
      } else if (value != null) {
        result[key] = value;
      }
    });

    return result;
  }

  Map<String, dynamic> _mergeSettingsSection(
    Map<String, dynamic> current,
    Map<String, dynamic> updates,
  ) {
    final result = Map<String, dynamic>.from(current);

    updates.forEach((key, value) {
      if (key == 'settings' && value is List<dynamic>) {
        // Merge settings arrays
        final currentSettings = result['settings'] as List<dynamic>? ?? [];
        final updatedSettings = value;
        
        // Create a map of existing settings by ID for quick lookup
        final existingSettingsMap = <String, Map<String, dynamic>>{};
        for (final setting in currentSettings) {
          if (setting is Map<String, dynamic> && setting['id'] != null) {
            existingSettingsMap[setting['id'] as String] = setting;
          }
        }
        
        // Add or update settings from the update
        for (final newSetting in updatedSettings) {
          if (newSetting is Map<String, dynamic> && newSetting['id'] != null) {
            existingSettingsMap[newSetting['id'] as String] = newSetting;
          }
        }
        
        // Convert back to list
        result['settings'] = existingSettingsMap.values.toList();
      } else if (value != null) {
        result[key] = value;
      }
    });

    return result;
  }
}
