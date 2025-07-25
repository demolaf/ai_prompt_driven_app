class ScaffoldConfig {
  ScaffoldConfig({required this.backgroundColor});

  final String backgroundColor;

  Map<String, dynamic> toJson() => {'backgroundColor': backgroundColor};

  factory ScaffoldConfig.fromJson(Map<String, dynamic> json) =>
      ScaffoldConfig(backgroundColor: json['backgroundColor'] ?? '');

  ScaffoldConfig copyWith({String? backgroundColor}) =>
      ScaffoldConfig(backgroundColor: backgroundColor ?? this.backgroundColor);
}
