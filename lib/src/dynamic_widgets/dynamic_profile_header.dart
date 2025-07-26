import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/config/profile_header_config.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';

class DynamicProfileHeader extends StatelessWidget {
  const DynamicProfileHeader({
    this.config,
    this.onAvatarTapped,
    super.key,
  });

  final ProfileHeaderConfig? config;
  final VoidCallback? onAvatarTapped;

  @override
  Widget build(BuildContext context) {
    // Use config values or fallback to defaults
    final showAvatar = config?.showAvatar ?? true;
    final showName = config?.showName ?? true;
    final showEmail = config?.showEmail ?? true;
    final spacing = config?.spacing ?? 16.0;

    // Filter out hidden elements
    final widgets = <Widget>[];

    if (showAvatar) {
      widgets.add(_buildAvatar());
    }

    if (showName) {
      widgets.add(_buildName());
    }

    if (showEmail) {
      widgets.add(_buildEmail());
    }

    if (widgets.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      children: widgets.asMap().entries.map((entry) {
        final isLast = entry.key == widgets.length - 1;
        return Column(
          children: [
            entry.value,
            if (!isLast) SizedBox(height: spacing),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildAvatar() {
    final avatarSize = config?.avatarSize ?? 120.0;
    final avatarBackgroundColor = config?.avatarBackgroundColor ?? CupertinoColors.systemGrey5;
    final avatarIcon = config?.avatarIcon ?? 'person';
    final avatarIconSize = config?.avatarIconSize ?? 60.0;
    final avatarIconColor = config?.avatarIconColor ?? CupertinoColors.systemGrey;
    final avatarImageUrl = config?.avatarImageUrl;

    return GestureDetector(
      onTap: onAvatarTapped,
      child: Container(
        width: avatarSize,
        height: avatarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: avatarBackgroundColor,
        ),
        child: _buildAvatarContent(
          avatarImageUrl: avatarImageUrl,
          avatarIcon: avatarIcon,
          avatarIconSize: avatarIconSize,
          avatarIconColor: avatarIconColor,
          avatarSize: avatarSize,
        ),
      ),
    );
  }

  Widget _buildAvatarContent({
    required String? avatarImageUrl,
    required String avatarIcon,
    required double avatarIconSize,
    required Color avatarIconColor,
    required double avatarSize,
  }) {
    if (avatarImageUrl != null && avatarImageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(avatarSize / 2),
        child: Image.network(
          avatarImageUrl,
          width: avatarSize,
          height: avatarSize,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to icon if network image fails
            return Icon(
              WidgetParser.parseIcon(avatarIcon),
              size: avatarIconSize,
              color: avatarIconColor,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            // Show loading icon while image loads
            return Icon(
              WidgetParser.parseIcon('refresh'),
              size: avatarIconSize * 0.8,
              color: avatarIconColor.withValues(alpha: 0.5),
            );
          },
        ),
      );
    }
    
    // Default to icon if no image URL provided
    return Icon(
      WidgetParser.parseIcon(avatarIcon),
      size: avatarIconSize,
      color: avatarIconColor,
    );
  }

  Widget _buildName() {
    final name = config?.name ?? 'John Doe';
    final nameFontSize = config?.nameFontSize ?? 24.0;
    final nameFontWeight = config?.nameFontWeight ?? FontWeight.bold;
    final nameColor = config?.nameColor ?? CupertinoColors.label;

    return Text(
      name,
      style: TextStyle(
        fontSize: nameFontSize,
        fontWeight: nameFontWeight,
        color: nameColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmail() {
    final email = config?.email ?? 'john.doe@example.com';
    final emailFontSize = config?.emailFontSize ?? 16.0;
    final emailColor = config?.emailColor ?? CupertinoColors.secondaryLabel;

    return Text(
      email,
      style: TextStyle(
        fontSize: emailFontSize,
        color: emailColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}