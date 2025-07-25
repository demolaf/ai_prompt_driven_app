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
          'icon': {
            'codePoint': 0xF89A, // attach_money icon
            'fontFamily': '',
            'fontPackage': '',
          },
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
              'icon': {
                'codePoint': 0xF3E2,
                'fontFamily': 'CupertinoIcons',
                'fontPackage': 'cupertino_icons',
              },
              'type': 'toggle',
              'value': true,
            },
          ],
        },
      },
    },
  ];
}
