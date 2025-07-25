import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class DebugLogger {
  static const String _prefix = '🤖 AI_APP';

  static void debug(String message, {String? tag, Object? data}) {
    _log(LogLevel.debug, message, tag: tag, data: data);
  }

  static void info(String message, {String? tag, Object? data}) {
    _log(LogLevel.info, message, tag: tag, data: data);
  }

  static void warning(String message, {String? tag, Object? data}) {
    _log(LogLevel.warning, message, tag: tag, data: data);
  }

  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(LogLevel.error, message, tag: tag, data: error);
    if (stackTrace != null) {
      debugPrint('$_prefix [STACK]: $stackTrace');
    }
  }

  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? data,
  }) {
    if (!kDebugMode) return;

    final emoji = _getEmoji(level);
    final levelName = level.name.toUpperCase();
    final tagStr = tag != null ? '[$tag]' : '';
    final timestamp = DateTime.now().toIso8601String().substring(11, 23);

    debugPrint('$_prefix $emoji [$levelName]$tagStr [$timestamp] $message');

    if (data != null) {
      debugPrint('$_prefix   └─ Data: $data');
    }
  }

  static String _getEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🔍';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
    }
  }

  // Specific loggers for different components
  static void viewModel(String viewModel, String action, {Object? data}) {
    debug('$viewModel: $action', tag: 'ViewModel', data: data);
  }

  static void aiCall(
    String provider,
    String prompt, {
    Object? response,
    Object? error,
  }) {
    if (error != null) {
      DebugLogger.error('AI call failed to $provider', tag: 'AI', error: error);
    } else {
      info(
        'AI call to $provider completed',
        tag: 'AI',
        data: {
          'prompt_length': prompt.length,
          'response_length': response?.toString().length ?? 0,
        },
      );
    }
  }

  static void stateChange(
    String component,
    String from,
    String to, {
    Object? data,
  }) {
    info('$component: $from → $to', tag: 'State', data: data);
  }

  static void userAction(String action, {Object? data}) {
    info('User action: $action', tag: 'UX', data: data);
  }
}
