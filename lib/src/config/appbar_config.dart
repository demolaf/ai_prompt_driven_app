import 'package:equatable/equatable.dart';

class AppBarConfig extends Equatable {
  factory AppBarConfig.fromJson(Map<String, dynamic> json) =>
      AppBarConfig(title: json['title'] ?? '');
  const AppBarConfig({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];

  Map<String, dynamic> toJson() => {'title': title};

  static Map<String, dynamic> get schema {
    return {
      'title': 'Home', // Example: app bar title text
    };
  }
}
