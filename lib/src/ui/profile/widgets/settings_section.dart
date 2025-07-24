import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/widgets/setting_tile.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.darkModeEnabled,
    required this.onDarkModeChanged,
  });

  final bool darkModeEnabled;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label,
          ),
        ),
        SizedBox(height: 16),
        SettingTile(
          title: 'Dark Mode',
          subtitle: 'Use dark theme',
          icon: CupertinoIcons.moon,
          value: darkModeEnabled,
          onChanged: onDarkModeChanged,
        ),
      ],
    );
  }
}
