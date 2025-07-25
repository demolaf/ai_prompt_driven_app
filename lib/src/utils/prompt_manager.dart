import 'dart:convert';
import 'dart:io';
import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:http/http.dart' as http;

class PromptManager {
  List<Prompt> getHomePrompts() {
    return Prompt.homePrompts.map(Prompt.fromJson).toList();
  }

  List<Prompt> getProfilePrompts() {
    return Prompt.profilePrompts.map(Prompt.fromJson).toList();
  }

  Prompt callStaticPrompt(String id) {
    return Prompt.allPrompts
        .map(Prompt.fromJson)
        .toList()
        .firstWhere((e) => e.id == id);
  }

  Future<Map<String, dynamic>?> callAIPrompt({
    required String userPrompt,
    ViewConfigurable? currentViewConfigurable,
  }) async {
    // 1) Resolve API key from parameter, dart-define, or env
    final key = (const String.fromEnvironment('OPENAI_API_KEY').isNotEmpty
        ? const String.fromEnvironment('OPENAI_API_KEY')
        : Platform.environment['OPENAI_API_KEY']);
    if (key == null || key.isEmpty) {
      throw Exception('OpenAI API key not provided');
    }

    // 2) Prepare the "current config" JSON
    final currentConfigJson = currentViewConfigurable?.toJson() ?? {};

    // 3) Build the chat messages
    final messages = [
      {
        'role': 'system',
        'content': '''
You are a Flutter UI configuration expert.
Given the current widget configuration and a user request,
respond with **only** the updated configuration JSON.
Do not include any explanations or extra fields.
''',
      },
      {
        'role': 'user',
        'content':
            'Current config: ${jsonEncode(currentConfigJson)}\nUser request: $userPrompt',
      },
    ];

    // 4) Call OpenAI
    final res = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $key',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': messages,
        'max_tokens': 1500,
        'temperature': 0.2,
      }),
    );

    // 5) Handle response
    if (res.statusCode != 200) {
      final err = jsonDecode(res.body);
      throw Exception('OpenAI Error: ${err['error']['message']}');
    }

    final data = jsonDecode(res.body);
    final content = (data['choices'][0]['message']['content'] as String).trim();

    // 6) Parse and return only the JSON
    return jsonDecode(content) as Map<String, dynamic>;
  }
}
