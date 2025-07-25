import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:equatable/equatable.dart';

class Prompt extends Equatable {
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

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['id'] as String,
      title: json['title'] as String,
      configurable: ViewConfigurable.fromJson(json['configurable']),
    );
  }

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
      'id': '442',
      'title': 'Update second stat card to Users',
      'configurable': {
        'type': 'home',
        'statCard2': {
          'title': 'Active Users',
          'value': '3,845',
          'icon': 'person',
          'backgroundColor': 'FFF3E5F5',
          'iconColor': 'FF9C27B0',
          'valueColor': 'FF7B1FA2',
        },
      },
    },
  ];

  static List<Map<String, dynamic>> get profilePrompts => [
    {
      'id': '123',
      'title': 'Make background red',
      'configurable': {
        'type': 'profile',
        'scaffoldConfig': {'backgroundColor': 'FF8B0000'},
        'appBarConfig': {'title': 'Profile'},
      },
    },
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
      'id': '457',
      'title': 'Add privacy and security settings',
      'configurable': {
        'type': 'profile',
        'settingsSectionConfig': {
          'settings': [
            {
              'id': 'privacy',
              'title': 'Privacy',
              'subtitle': 'Manage your privacy settings',
              'icon': 'privacy',
              'type': 'navigation',
            },
            {
              'id': 'security',
              'title': 'Security',
              'subtitle': 'Account security settings',
              'icon': 'security',
              'type': 'navigation',
            },
          ],
        },
      },
    },
  ];
}
