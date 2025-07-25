class AppBarConfig {
  AppBarConfig({required this.title});

  final String title;

  Map<String, dynamic> toJson() => {'title': title};

  factory AppBarConfig.fromJson(Map<String, dynamic> json) =>
      AppBarConfig(title: json['title'] ?? '');

  AppBarConfig copyWith({String? title}) =>
      AppBarConfig(title: title ?? this.title);
}
