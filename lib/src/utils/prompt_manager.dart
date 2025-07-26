import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:ai_prompt_driven_app/src/utils/debug_logger.dart';
import 'package:http/http.dart' as http;

enum AIProvider { openai, anthropic }

class PromptManager {
  List<Prompt> getHomePrompts() {
    return Prompt.homePrompts.map(Prompt.fromJson).toList();
  }

  List<Prompt> getProfilePrompts() {
    return Prompt.profilePrompts.map(Prompt.fromJson).toList();
  }

  Prompt callStaticPrompt(String id) {
    DebugLogger.info('callStaticPrompt', data: {'promptId': id});
    return Prompt.allPrompts
        .map(Prompt.fromJson)
        .toList()
        .firstWhere((e) => e.id == id);
  }

  Future<Map<String, dynamic>?> callAIPrompt({
    required String userPrompt,
    required ViewConfigurable currentViewConfigurable,
    required Map<String, dynamic> viewConfigurableSchema,
    AIProvider provider = AIProvider.anthropic,
  }) async {
    DebugLogger.userAction(
      'AI prompt request',
      data: {
        'promptLength': userPrompt.length,
        'provider': provider.name,
        'prompt': userPrompt.substring(
          0,
          userPrompt.length > 100 ? 100 : userPrompt.length,
        ),
      },
    );

    try {
      final result = switch (provider) {
        AIProvider.openai => await _callOpenAIPrompt(
          userPrompt,
          currentViewConfigurable,
          viewConfigurableSchema,
        ),
        AIProvider.anthropic => await _callAnthropicPrompt(
          userPrompt,
          currentViewConfigurable,
          viewConfigurableSchema,
        ),
      };

      DebugLogger.aiCall(provider.name, userPrompt, response: result);
      return result;
    } catch (e, stackTrace) {
      DebugLogger.error(
        'AI prompt failed',
        tag: 'PromptManager',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> _callOpenAIPrompt(
    String userPrompt,
    ViewConfigurable currentViewConfigurable,
    Map<String, dynamic> viewConfigurableSchema,
  ) async {
    final key = (const String.fromEnvironment('OPENAI_API_KEY').isNotEmpty
        ? const String.fromEnvironment('OPENAI_API_KEY')
        : Platform.environment['OPENAI_API_KEY']);

    if (key == null || key.isEmpty) {
      throw Exception('OpenAI API key not provided');
    }

    final messages = [
      {
        'role': 'system',
        'content': '''
You are a Flutter UI configuration expert.
You will receive a JSON schema, current configuration state, and a user request for UI changes.

You must respond with **only** a JSON object containing the requested changes.
- Use the schema to understand available properties and their types
- Consider the current configuration to understand existing customizations
- Only include the properties that need to be changed from the current state
- Return valid JSON that matches the schema structure
- Do not include explanations, comments, or extra fields

Response format: Pure JSON object only
''',
      },
      {
        'role': 'user',
        'content':
            '''
Schema:
${jsonEncode(viewConfigurableSchema)}

Current Configuration:
${jsonEncode(currentViewConfigurable.toJson())}

User request: $userPrompt''',
      },
    ];

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

    if (res.statusCode != 200) {
      final err = jsonDecode(res.body);
      throw Exception('OpenAI Error: ${err['error']['message']}');
    }

    final data = jsonDecode(res.body);
    final content = (data['choices'][0]['message']['content'] as String).trim();

    DebugLogger.info(
      'OpenAI raw response',
      data: {
        'statusCode': res.statusCode,
        'content': content,
        'usage': data['usage'],
      },
    );

    final parsedResult = jsonDecode(content) as Map<String, dynamic>;

    DebugLogger.info(
      'OpenAI parsed result',
      data: {
        'parsedKeys': parsedResult.keys.toList(),
        'parsedData': parsedResult,
      },
    );

    return parsedResult;
  }

  Future<Map<String, dynamic>?> _callAnthropicPrompt(
    String userPrompt,
    ViewConfigurable currentViewConfigurable,
    Map<String, dynamic> viewConfigurableSchema,
  ) async {
    final key = (const String.fromEnvironment('ANTHROPIC_API_KEY').isNotEmpty
        ? const String.fromEnvironment('ANTHROPIC_API_KEY')
        : Platform.environment['ANTHROPIC_API_KEY']);

    if (key == null || key.isEmpty) {
      throw Exception('Anthropic API key not provided');
    }

    final prompt =
        '''
You are a Flutter UI configuration expert.
You will receive a JSON schema, current configuration state, and a user request for UI changes.

You must respond with **only** a JSON object containing the requested changes.
- Use the schema to understand available properties and their types
- Consider the current configuration to understand existing customizations
- Only include the properties that need to be changed from the current state
- Return valid JSON that matches the schema structure
- Do not include explanations, comments, or extra fields

Schema:
${jsonEncode(viewConfigurableSchema)}

Current Configuration:
${jsonEncode(currentViewConfigurable.toJson())}

User request: $userPrompt

Response (JSON only):''';

    final res = await http.post(
      Uri.parse('https://api.anthropic.com/v1/messages'),
      headers: {
        'x-api-key': key,
        'Content-Type': 'application/json',
        'anthropic-version': '2023-06-01',
      },
      body: jsonEncode({
        'model': 'claude-3-haiku-20240307',
        'max_tokens': 1500,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      }),
    );

    if (res.statusCode != 200) {
      final err = jsonDecode(res.body);
      throw Exception('Anthropic Error: ${err['error']['message']}');
    }

    final data = jsonDecode(res.body);
    final content = (data['content'][0]['text'] as String).trim();

    DebugLogger.info(
      'Anthropic raw response',
      data: {
        'statusCode': res.statusCode,
        'content': content,
        'usage': data['usage'],
      },
    );

    // Extract JSON from Claude's response (it might include explanations)
    final jsonMatch = RegExp(r'\{[\s\S]*\}').firstMatch(content);
    Map<String, dynamic> parsedResult;

    if (jsonMatch != null) {
      final extractedJson = jsonMatch.group(0)!;
      DebugLogger.info(
        'Anthropic extracted JSON',
        data: {'extractedJson': extractedJson},
      );
      parsedResult = jsonDecode(extractedJson) as Map<String, dynamic>;
    } else {
      // If no JSON found, try parsing the entire content
      try {
        parsedResult = jsonDecode(content) as Map<String, dynamic>;
        DebugLogger.info('Anthropic parsed entire content as JSON');
      } catch (e) {
        DebugLogger.error(
          'Failed to parse Anthropic response as JSON: $content',
          tag: 'PromptManager',
          error: e,
        );
        throw Exception(
          'Could not extract valid JSON from Anthropic response: $content',
        );
      }
    }

    DebugLogger.info(
      'Anthropic parsed result',
      data: {
        'parsedKeys': parsedResult.keys.toList(),
        'parsedData': parsedResult,
      },
    );

    // Additional logging for all AI responses
    if (kDebugMode) {
      print('=== FULL AI RESPONSE ===');
      print(parsedResult);
      print('========================');
    }

    return parsedResult;
  }
}
