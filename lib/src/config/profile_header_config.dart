import 'package:flutter/cupertino.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';

class ProfileHeaderConfig {
  factory ProfileHeaderConfig.fromJson(Map<String, dynamic> json) {
    return ProfileHeaderConfig(
      avatarSize: WidgetParser.parseDoubleFromJson(json['avatarSize']),
      avatarBackgroundColor: WidgetParser.parseColorFromJson(
        json['avatarBackgroundColor'],
      ),
      avatarIcon: json['avatarIcon'] as String?,
      avatarIconSize: WidgetParser.parseDoubleFromJson(json['avatarIconSize']),
      avatarIconColor: WidgetParser.parseColorFromJson(json['avatarIconColor']),
      avatarImageUrl: json['avatarImageUrl'] as String?,
      spacing: WidgetParser.parseDoubleFromJson(json['spacing']),
      name: json['name'] as String?,
      nameFontSize: WidgetParser.parseDoubleFromJson(json['nameFontSize']),
      nameFontWeight: json['nameFontWeight'] != null
          ? WidgetParser.parseFontWeight(json['nameFontWeight'] as String)
          : null,
      nameColor: WidgetParser.parseColorFromJson(json['nameColor']),
      email: json['email'] as String?,
      emailFontSize: WidgetParser.parseDoubleFromJson(json['emailFontSize']),
      emailColor: WidgetParser.parseColorFromJson(json['emailColor']),
      showAvatar: json['showAvatar'] as bool? ?? true,
      showName: json['showName'] as bool? ?? true,
      showEmail: json['showEmail'] as bool? ?? true,
    );
  }
  const ProfileHeaderConfig({
    this.avatarSize,
    this.avatarBackgroundColor,
    this.avatarIcon,
    this.avatarIconSize,
    this.avatarIconColor,
    this.avatarImageUrl,
    this.spacing,
    this.name,
    this.nameFontSize,
    this.nameFontWeight,
    this.nameColor,
    this.email,
    this.emailFontSize,
    this.emailColor,
    this.showAvatar = true,
    this.showName = true,
    this.showEmail = true,
  });

  final double? avatarSize;
  final Color? avatarBackgroundColor;
  final String? avatarIcon;
  final double? avatarIconSize;
  final Color? avatarIconColor;
  final String? avatarImageUrl;
  final double? spacing;
  final String? name;
  final double? nameFontSize;
  final FontWeight? nameFontWeight;
  final Color? nameColor;
  final String? email;
  final double? emailFontSize;
  final Color? emailColor;
  final bool showAvatar;
  final bool showName;
  final bool showEmail;

  Map<String, dynamic> toJson() {
    return {
      if (avatarSize != null) 'avatarSize': avatarSize,
      if (avatarBackgroundColor != null)
        'avatarBackgroundColor': WidgetParser.colorToInt(
          avatarBackgroundColor!,
        ),
      if (avatarIcon != null) 'avatarIcon': avatarIcon,
      if (avatarIconSize != null) 'avatarIconSize': avatarIconSize,
      if (avatarIconColor != null)
        'avatarIconColor': WidgetParser.colorToInt(avatarIconColor!),
      'avatarImageUrl': avatarImageUrl,
      if (spacing != null) 'spacing': spacing,
      if (name != null) 'name': name,
      if (nameFontSize != null) 'nameFontSize': nameFontSize,
      if (nameFontWeight != null)
        'nameFontWeight': WidgetParser.fontWeightToString(nameFontWeight!),
      if (nameColor != null) 'nameColor': WidgetParser.colorToInt(nameColor!),
      if (email != null) 'email': email,
      if (emailFontSize != null) 'emailFontSize': emailFontSize,
      if (emailColor != null)
        'emailColor': WidgetParser.colorToInt(emailColor!),
      'showAvatar': showAvatar,
      'showName': showName,
      'showEmail': showEmail,
    };
  }

  static Map<String, dynamic> get schema => {
    'type': 'object',
    'properties': {
      'avatarSize': {
        'type': 'number',
        'description': 'Size of the circular avatar (width and height)',
      },
      'avatarBackgroundColor': {
        'type': 'integer',
        'description': 'Background color of the avatar circle',
      },
      'avatarIcon': {
        'type': 'string',
        'description': '''Avatar icon name. Common examples:
        
- 'person' - Default person icon
- 'star' - Star icon for VIP users
- 'settings' - Settings/admin icon
- 'help' - Support user icon
- 'globe' - International user icon''',
      },
      'avatarIconSize': {
        'type': 'number',
        'description': 'Size of the icon inside the avatar',
      },
      'avatarIconColor': {
        'type': 'integer',
        'description': 'Color of the avatar icon',
      },
      'avatarImageUrl': {
        'type': 'string',
        'description':
            'Network image URL for avatar. When provided, takes precedence over avatarIcon. Use HTTPS URLs for security.',
      },
      'spacing': {
        'type': 'number',
        'description': 'Spacing between avatar and text elements',
      },
      'name': {'type': 'string', 'description': 'User display name'},
      'nameFontSize': {
        'type': 'number',
        'description': 'Font size for the user name',
      },
      'nameFontWeight': {
        'type': 'string',
        'enum': [
          'w100',
          'w200',
          'w300',
          'w400',
          'w500',
          'w600',
          'w700',
          'w800',
          'w900',
          'normal',
          'bold',
          'semibold',
        ],
        'description': 'Font weight for the user name',
      },
      'nameColor': {
        'type': 'integer',
        'description': 'Color of the user name text',
      },
      'email': {'type': 'string', 'description': 'User email address'},
      'emailFontSize': {
        'type': 'number',
        'description': 'Font size for the email text',
      },
      'emailColor': {
        'type': 'integer',
        'description': 'Color of the email text',
      },
      'showAvatar': {
        'type': 'boolean',
        'description': 'Whether to show the avatar circle',
      },
      'showName': {
        'type': 'boolean',
        'description': 'Whether to show the user name',
      },
      'showEmail': {
        'type': 'boolean',
        'description': 'Whether to show the email address',
      },
    },
  };
}
