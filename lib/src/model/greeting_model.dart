class GreetingModel {
  final String greeting;
  final String question;
  final String language;

  const GreetingModel({
    required this.greeting,
    required this.question,
    required this.language,
  });

  static List<GreetingModel> get getPlaceholderData => [
    GreetingModel(
      greeting: 'Hello',
      question: 'How are you?',
      language: 'English',
    ),
    GreetingModel(
      greeting: 'Hola',
      question: '¿Cómo estás?',
      language: 'Spanish',
    ),
    GreetingModel(
      greeting: 'Bonjour',
      question: 'Comment allez-vous?',
      language: 'French',
    ),
    GreetingModel(greeting: 'こんにちは', question: '元気ですか？', language: 'Japanese'),
    GreetingModel(
      greeting: 'Hallo',
      question: 'Wie geht es dir?',
      language: 'German',
    ),
    GreetingModel(
      greeting: 'Ciao',
      question: 'Come stai?',
      language: 'Italian',
    ),
  ];
}
