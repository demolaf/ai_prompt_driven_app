import 'package:equatable/equatable.dart';

class AppBarConfig extends Equatable {
  const AppBarConfig({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];

  Map<String, dynamic> toJson() => {'title': title};

  factory AppBarConfig.fromJson(Map<String, dynamic> json) =>
      AppBarConfig(title: json['title'] ?? '');

  AppBarConfig copyWith({String? title}) =>
      AppBarConfig(title: title ?? this.title);

  static Map<String, dynamic> get schema {
    return {
      'title': 'Home' // Example: app bar title text
    };
  }
}
