import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/model/setting_model.dart';
import 'package:ai_prompt_driven_app/src/model/settings_section_config.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/widgets/setting_tile.dart';

class DynamicSettingsSection extends StatelessWidget {
  const DynamicSettingsSection({this.config, this.onSettingChanged, super.key});

  final SettingsSectionConfig? config;
  final Function(String id, dynamic value)? onSettingChanged;

  @override
  Widget build(BuildContext context) {
    // Use config values or fallback to minimal defaults
    final title = config?.title ?? 'Settings';
    final titleFontSize = config?.titleFontSize ?? 16.0;
    final titleColor = config?.titleColor ?? CupertinoColors.systemGrey;
    final titleFontWeight = config?.titleFontWeight ?? FontWeight.normal;
    final spacing = config?.spacing ?? 12.0;
    final settingsList = config?.settings ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: titleFontWeight,
            color: titleColor,
          ),
        ),
        SizedBox(height: spacing),
        ...settingsList.map((setting) {
          return SettingTile(
            setting: setting.copyWith(
              onToggle: setting.type == SettingType.toggle
                  ? (value) => onSettingChanged?.call(setting.id, value)
                  : null,
              onTap: setting.type != SettingType.toggle
                  ? () => onSettingChanged?.call(setting.id, null)
                  : null,
            ),
          );
        }),
      ],
    );
  }
}
