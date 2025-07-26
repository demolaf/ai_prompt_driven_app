import 'package:flutter/cupertino.dart';

class ProfileHeaderConfig {
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

  factory ProfileHeaderConfig.fromJson(Map<String, dynamic> json) {
    return ProfileHeaderConfig(
      avatarSize: json['avatarSize']?.toDouble(),
      avatarBackgroundColor: json['avatarBackgroundColor'] != null
          ? Color(json['avatarBackgroundColor'])
          : null,
      avatarIcon: json['avatarIcon'] as String?,
      avatarIconSize: json['avatarIconSize']?.toDouble(),
      avatarIconColor: json['avatarIconColor'] != null
          ? Color(json['avatarIconColor'])
          : null,
      avatarImageUrl: json['avatarImageUrl'] as String?,
      spacing: json['spacing']?.toDouble(),
      name: json['name'] as String?,
      nameFontSize: json['nameFontSize']?.toDouble(),
      nameFontWeight: json['nameFontWeight'] != null
          ? _getFontWeightFromString(json['nameFontWeight'] as String)
          : null,
      nameColor: json['nameColor'] != null ? Color(json['nameColor']) : null,
      email: json['email'] as String?,
      emailFontSize: json['emailFontSize']?.toDouble(),
      emailColor: json['emailColor'] != null ? Color(json['emailColor']) : null,
      showAvatar: json['showAvatar'] as bool? ?? true,
      showName: json['showName'] as bool? ?? true,
      showEmail: json['showEmail'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (avatarSize != null) 'avatarSize': avatarSize,
      if (avatarBackgroundColor != null) 'avatarBackgroundColor': avatarBackgroundColor!.toARGB32(),
      if (avatarIcon != null) 'avatarIcon': avatarIcon,
      if (avatarIconSize != null) 'avatarIconSize': avatarIconSize,
      if (avatarIconColor != null) 'avatarIconColor': avatarIconColor!.toARGB32(),
      'avatarImageUrl': avatarImageUrl,
      if (spacing != null) 'spacing': spacing,
      if (name != null) 'name': name,
      if (nameFontSize != null) 'nameFontSize': nameFontSize,
      if (nameFontWeight != null) 'nameFontWeight': _getStringFromFontWeight(nameFontWeight!),
      if (nameColor != null) 'nameColor': nameColor!.toARGB32(),
      if (email != null) 'email': email,
      if (emailFontSize != null) 'emailFontSize': emailFontSize,
      if (emailColor != null) 'emailColor': emailColor!.toARGB32(),
      'showAvatar': showAvatar,
      'showName': showName,
      'showEmail': showEmail,
    };
  }

  ProfileHeaderConfig copyWith({
    double? avatarSize,
    Color? avatarBackgroundColor,
    String? avatarIcon,
    double? avatarIconSize,
    Color? avatarIconColor,
    String? avatarImageUrl,
    double? spacing,
    String? name,
    double? nameFontSize,
    FontWeight? nameFontWeight,
    Color? nameColor,
    String? email,
    double? emailFontSize,
    Color? emailColor,
    bool? showAvatar,
    bool? showName,
    bool? showEmail,
  }) {
    return ProfileHeaderConfig(
      avatarSize: avatarSize ?? this.avatarSize,
      avatarBackgroundColor: avatarBackgroundColor ?? this.avatarBackgroundColor,
      avatarIcon: avatarIcon ?? this.avatarIcon,
      avatarIconSize: avatarIconSize ?? this.avatarIconSize,
      avatarIconColor: avatarIconColor ?? this.avatarIconColor,
      avatarImageUrl: avatarImageUrl ?? this.avatarImageUrl,
      spacing: spacing ?? this.spacing,
      name: name ?? this.name,
      nameFontSize: nameFontSize ?? this.nameFontSize,
      nameFontWeight: nameFontWeight ?? this.nameFontWeight,
      nameColor: nameColor ?? this.nameColor,
      email: email ?? this.email,
      emailFontSize: emailFontSize ?? this.emailFontSize,
      emailColor: emailColor ?? this.emailColor,
      showAvatar: showAvatar ?? this.showAvatar,
      showName: showName ?? this.showName,
      showEmail: showEmail ?? this.showEmail,
    );
  }

  static FontWeight _getFontWeightFromString(String fontWeight) {
    switch (fontWeight) {
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
      case 'normal':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
      case 'semibold':
        return FontWeight.w600;
      case 'w700':
      case 'bold':
        return FontWeight.w700;
      case 'w800':
        return FontWeight.w800;
      case 'w900':
        return FontWeight.w900;
      default:
        return FontWeight.w600;
    }
  }

  static String _getStringFromFontWeight(FontWeight fontWeight) {
    switch (fontWeight) {
      case FontWeight.w100:
        return 'w100';
      case FontWeight.w200:
        return 'w200';
      case FontWeight.w300:
        return 'w300';
      case FontWeight.w400:
        return 'w400';
      case FontWeight.w500:
        return 'w500';
      case FontWeight.w600:
        return 'w600';
      case FontWeight.w700:
        return 'w700';
      case FontWeight.w800:
        return 'w800';
      case FontWeight.w900:
        return 'w900';
      default:
        return 'w600';
    }
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
        'description': 'Network image URL for avatar. When provided, takes precedence over avatarIcon. Use HTTPS URLs for security.',
      },
      'spacing': {
        'type': 'number',
        'description': 'Spacing between avatar and text elements',
      },
      'name': {
        'type': 'string',
        'description': 'User display name',
      },
      'nameFontSize': {
        'type': 'number',
        'description': 'Font size for the user name',
      },
      'nameFontWeight': {
        'type': 'string',
        'enum': [
          'w100', 'w200', 'w300', 'w400', 'w500', 'w600', 'w700', 'w800', 'w900',
          'normal', 'bold', 'semibold',
        ],
        'description': 'Font weight for the user name',
      },
      'nameColor': {
        'type': 'integer',
        'description': 'Color of the user name text',
      },
      'email': {
        'type': 'string',
        'description': 'User email address',
      },
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