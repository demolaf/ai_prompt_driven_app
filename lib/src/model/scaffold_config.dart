import 'package:equatable/equatable.dart';

class ScaffoldConfig extends Equatable {
  const ScaffoldConfig({required this.backgroundColor});

  final String backgroundColor;

  @override
  List<Object?> get props => [backgroundColor];

  Map<String, dynamic> toJson() => {'backgroundColor': backgroundColor};

  factory ScaffoldConfig.fromJson(Map<String, dynamic> json) =>
      ScaffoldConfig(backgroundColor: json['backgroundColor'] ?? '');

  ScaffoldConfig copyWith({String? backgroundColor}) =>
      ScaffoldConfig(backgroundColor: backgroundColor ?? this.backgroundColor);
}
