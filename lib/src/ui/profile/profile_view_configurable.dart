import 'package:ai_prompt_driven_app/src/config/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/config/profile_header_config.dart';
import 'package:ai_prompt_driven_app/src/config/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/config/settings_section_config.dart';
import 'package:ai_prompt_driven_app/src/config/stats_section_config.dart';
import 'package:ai_prompt_driven_app/src/model/setting_model.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewConfigurable extends Equatable implements ViewConfigurable {
  const ProfileViewConfigurable({
    this.scaffoldConfig,
    this.appBarConfig,
    this.profileHeaderConfig,
    this.statsSectionConfig,
    this.settingsSectionConfig,
  });

  ProfileViewConfigurable.initial()
    : this(
        scaffoldConfig: ScaffoldConfig(backgroundColor: 'FFFFFFFF'),
        appBarConfig: AppBarConfig(title: 'Profile'),
        profileHeaderConfig: ProfileHeaderConfig(
          avatarSize: 120.0,
          avatarBackgroundColor: CupertinoColors.systemGrey5,
          avatarIcon: 'person',
          avatarIconSize: 60.0,
          avatarIconColor: CupertinoColors.systemGrey,
          spacing: 16.0,
          name: 'John Doe',
          nameFontSize: 24.0,
          nameFontWeight: FontWeight.bold,
          nameColor: CupertinoColors.label,
          email: 'john.doe@example.com',
          emailFontSize: 16.0,
          emailColor: CupertinoColors.secondaryLabel,
          showAvatar: true,
          showName: true,
          showEmail: true,
        ),
        statsSectionConfig: StatsSectionConfig(
          conversationsValue: '1,247',
          daysActiveValue: '35',
          wordsGeneratedValue: '2.4k',
        ),
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
      profileHeaderConfig: json['profileHeaderConfig'] != null
          ? ProfileHeaderConfig.fromJson(json['profileHeaderConfig'])
          : null,
      statsSectionConfig: json['statsSectionConfig'] != null
          ? StatsSectionConfig.fromJson(json['statsSectionConfig'])
          : null,
      settingsSectionConfig: json['settingsSectionConfig'] != null
          ? SettingsSectionConfig.fromJson(json['settingsSectionConfig'])
          : null,
    );
  }

  final ScaffoldConfig? scaffoldConfig;
  final AppBarConfig? appBarConfig;
  final ProfileHeaderConfig? profileHeaderConfig;
  final StatsSectionConfig? statsSectionConfig;
  final SettingsSectionConfig? settingsSectionConfig;

  @override
  List<Object?> get props => [
    scaffoldConfig,
    appBarConfig,
    profileHeaderConfig,
    statsSectionConfig,
    settingsSectionConfig,
  ];

  @override
  Map<String, dynamic> toJson() {
    return {
      if (scaffoldConfig != null) 'scaffoldConfig': scaffoldConfig!.toJson(),
      if (appBarConfig != null) 'appBarConfig': appBarConfig!.toJson(),
      if (profileHeaderConfig != null) 'profileHeaderConfig': profileHeaderConfig!.toJson(),
      if (statsSectionConfig != null) 'statsSectionConfig': statsSectionConfig!.toJson(),
      if (settingsSectionConfig != null) 'settingsSectionConfig': settingsSectionConfig!.toJson(),
    };
  }

  static Map<String, dynamic> get schema {
    return {
      'scaffoldConfig': ScaffoldConfig.schema,
      'appBarConfig': AppBarConfig.schema,
      'profileHeaderConfig': ProfileHeaderConfig.schema,
      'statsSectionConfig': StatsSectionConfig.schema,
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
      } else {
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
            final settingId = newSetting['id'] as String;
            if (existingSettingsMap.containsKey(settingId)) {
              // Merge with existing setting, preserving all fields
              final existing = Map<String, dynamic>.from(existingSettingsMap[settingId]!);
              newSetting.forEach((key, value) {
                existing[key] = value;
              });
              existingSettingsMap[settingId] = existing;
            } else {
              // New setting, add as-is
              existingSettingsMap[settingId] = newSetting;
            }
          } else if (newSetting is Map<String, dynamic>) {
            // AI didn't provide ID - try to infer which setting to update
            final inferredId = _inferSettingId(newSetting, existingSettingsMap);
            if (inferredId != null) {
              final existing = Map<String, dynamic>.from(existingSettingsMap[inferredId]!);
              newSetting.forEach((key, value) {
                if (key != 'id') { // Don't overwrite the ID
                  existing[key] = value;
                }
              });
              existingSettingsMap[inferredId] = existing;
            }
          }
        }
        
        // Convert back to list
        result['settings'] = existingSettingsMap.values.toList();
      } else {
        result[key] = value;
      }
    });

    return result;
  }

  /// Infers which setting ID to use when AI doesn't provide one
  String? _inferSettingId(Map<String, dynamic> newSetting, Map<String, Map<String, dynamic>> existingSettings) {
    // Strategy 1: If only updating 'value' and there's only one toggle setting, use that
    if (newSetting.keys.length == 1 && newSetting.containsKey('value') && newSetting['value'] is bool) {
      final toggleSettings = existingSettings.entries
          .where((entry) => entry.value['type'] == 'toggle')
          .toList();
      
      if (toggleSettings.length == 1) {
        return toggleSettings.first.key;
      }
    }

    // Strategy 2: Match by title or subtitle if provided
    if (newSetting['title'] != null) {
      for (final entry in existingSettings.entries) {
        if (entry.value['title'] == newSetting['title']) {
          return entry.key;
        }
      }
    }

    // Strategy 3: Match by other properties like icon
    if (newSetting['icon'] != null) {
      for (final entry in existingSettings.entries) {
        if (entry.value['icon'] == newSetting['icon']) {
          return entry.key;
        }
      }
    }

    return null; // Could not infer
  }
}
