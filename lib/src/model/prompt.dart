import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:equatable/equatable.dart';

class Prompt extends Equatable {
  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['id'] as String,
      title: json['title'] as String,
      configurable: ViewConfigurable.fromJson(json['configurable']),
    );
  }
  const Prompt({
    required this.id,
    required this.title,
    required this.configurable,
  });

  final String id;
  final String title;
  final ViewConfigurable configurable;

  @override
  List<Object?> get props => [id, title, configurable];

  static List<Map<String, dynamic>> get allPrompts {
    return [...homePrompts, ...profilePrompts];
  }

  static List<Map<String, dynamic>> get homePrompts => [
    {
      'id': '121',
      'title': 'Make background blue',
      'configurable': {
        'type': 'home',
        'scaffoldConfig': {'backgroundColor': 'FF00008B'},
      },
    },
    {
      'id': '221',
      'title': 'Change the app bar title to Dashboard',
      'configurable': {
        'type': 'home',
        'appBarConfig': {'title': 'Dashboard'},
      },
    },
    {
      'id': '331',
      'title': 'Change first stat card to Revenue',
      'configurable': {
        'type': 'home',
        'statCard1': {
          'title': 'Monthly Revenue',
          'value': '\$24,750',
          'icon': 'attach_money',
          'backgroundColor': 'FFE8F5E8',
          'iconColor': 'FF4CAF50',
          'valueColor': 'FF2E7D32',
        },
      },
    },
    {
      'id': '441',
      'title': 'Make greeting cards sunset themed',
      'configurable': {
        'type': 'home',
        'greetingCardConfig': {
          'gradientColors': [4294937600, 4294951175],
          // Orange to Pink gradient
        },
      },
    },
    {
      'id': '445',
      'title': 'Add productivity quick actions',
      'configurable': {
        'type': 'home',
        'quickActionConfig': {
          'title': 'Productivity Tools',
          'layout': 'grid',
          'titleFontSize': 20.0,
          'titleFontWeight': 'bold',
          'spacing': 16.0,
          'crossAxisSpacing': 16.0,
          'mainAxisSpacing': 12.0,
          'actions': [
            {
              'id': 'create_task',
              'title': 'Create Task',
              'icon': 'save',
              'color': 4278238420,
              'backgroundColor': 4293718783,
            },
            {
              'id': 'send_message',
              'title': 'Send Message',
              'icon': 'send',
              'color': 4282549748,
              'backgroundColor': 4294308607,
            },
            {
              'id': 'get_help',
              'title': 'Get Help',
              'icon': 'help',
              'color': 4288423856,
              'backgroundColor': 4294633471,
            },
            {
              'id': 'location_info',
              'title': 'Location Info',
              'icon': 'location',
              'color': 4291559424,
              'backgroundColor': 4294965248,
            },
          ],
        },
      },
    },
  ];

  static List<Map<String, dynamic>> get profilePrompts => [
    {
      'id': '456',
      'title': 'Add notification settings',
      'configurable': {
        'type': 'profile',
        'settingsSectionConfig': {
          'settings': [
            {
              'id': 'notifications',
              'title': 'Notifications',
              'subtitle': 'Enable push notifications',
              'icon': 'notifications',
              'type': 'toggle',
              'value': true,
            },
          ],
        },
      },
    },
    {
      'id': '789',
      'title': 'Customize profile header with star avatar',
      'configurable': {
        'type': 'profile',
        'profileHeaderConfig': {
          'avatarSize': 140.0,
          'avatarBackgroundColor': 4294951175,
          'avatarIcon': 'star',
          'avatarIconSize': 70.0,
          'avatarIconColor': 4294944000,
          'avatarImageUrl': null,
          'spacing': 20.0,
          'name': 'Sarah Johnson',
          'nameFontSize': 28.0,
          'nameFontWeight': 'bold',
          'nameColor': 4278190080,
          'email': 'sarah.johnson@company.com',
          'emailFontSize': 18.0,
          'emailColor': 4286611584,
        },
      },
    },
    {
      'id': '792',
      'title': 'Use network image for avatar',
      'configurable': {
        'type': 'profile',
        'profileHeaderConfig': {
          'avatarSize': 130.0,
          'avatarImageUrl': 'https://picsum.photos/200/200?random=1',
          'name': 'Emma Wilson',
          'nameFontSize': 26.0,
          'nameFontWeight': 'bold',
          'nameColor': 4278190080,
          'email': 'emma.wilson@example.com',
          'emailFontSize': 16.0,
          'emailColor': 4286611584,
          'spacing': 18.0,
        },
      },
    },
    {
      'id': '800',
      'title': 'Update stats to show productivity metrics',
      'configurable': {
        'type': 'profile',
        'statsSectionConfig': {
          'conversationsValue': '2,456',
          'daysActiveValue': '87',
          'wordsGeneratedValue': '15.2k',
          'conversationsLabel': 'Total Chats',
          'daysActiveLabel': 'Days Streak',
          'wordsGeneratedLabel': 'Words Written',
          'backgroundColor': 'FFF0F8FF',
          'padding': 24.0,
          'borderRadius': 16.0,
        },
      },
    },
  ];
}
