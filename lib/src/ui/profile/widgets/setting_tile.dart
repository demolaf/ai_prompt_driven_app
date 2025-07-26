import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/model/setting.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({required this.setting, super.key});

  final SettingModel setting;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: setting.onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              WidgetParser.parseIcon(setting.icon),
              size: 24,
              color: CupertinoColors.systemBlue,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    setting.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.label,
                    ),
                  ),
                  Text(
                    setting.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
            _buildTrailing(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    switch (setting.type) {
      case SettingType.toggle:
        return CupertinoSwitch(
          value: setting.value ?? false,
          onChanged: setting.onToggle,
        );
      case SettingType.navigation:
        return Icon(
          CupertinoIcons.chevron_right,
          size: 16,
          color: CupertinoColors.systemGrey2,
        );
      case SettingType.action:
        return SizedBox.shrink();
    }
  }
}
