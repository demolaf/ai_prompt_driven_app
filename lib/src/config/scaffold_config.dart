import 'package:equatable/equatable.dart';

class ScaffoldConfig extends Equatable {
  factory ScaffoldConfig.fromJson(Map<String, dynamic> json) =>
      ScaffoldConfig(backgroundColor: json['backgroundColor'] ?? '');
  const ScaffoldConfig({required this.backgroundColor});

  final String backgroundColor;

  @override
  List<Object?> get props => [backgroundColor];

  Map<String, dynamic> toJson() => {'backgroundColor': backgroundColor};

  static Map<String, dynamic> get schema {
    return {
      'backgroundColor':
          'FFFFFFFF', // Example: white background (hex ARGB format)
    };
  }
}
