import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/model/stat_card_config.dart';
import 'package:ai_prompt_driven_app/src/model/greeting_card_config.dart';
import 'package:ai_prompt_driven_app/src/model/settings_section_config.dart';
import 'package:ai_prompt_driven_app/src/ui/home/home_view_configurable.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view_configurable.dart';

abstract class ViewConfigurable {
  static ViewConfigurable fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'home':
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
        );
      case 'profile':
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
      default:
        throw UnsupportedError(
          'Unknown ViewConfigurable type: ${json['type']}',
        );
    }
  }

  Map<String, dynamic> toJson();

  ViewConfigurable merge(Map<String, dynamic> updates);
}
