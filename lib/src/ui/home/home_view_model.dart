import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/ui/home/home_view_configurable.dart';
import 'package:ai_prompt_driven_app/src/utils/prompt_manager.dart';
import 'package:ai_prompt_driven_app/src/utils/debug_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum HomeViewState { initial, loading, ready, error }

class HomeState extends Equatable {
  const HomeState({
    required this.viewState,
    this.availablePrompts = const [],
    this.configurable,
    this.errorMessage,
    this.isProcessing = false,
  });

  HomeState.initial()
    : this(
        viewState: HomeViewState.initial,
        availablePrompts: [],
        configurable: HomeViewConfigurable.initial(),
      );

  final HomeViewState viewState;
  final List<Prompt> availablePrompts;
  final HomeViewConfigurable? configurable;
  final String? errorMessage;
  final bool isProcessing;

  @override
  List<Object?> get props => [
    viewState,
    availablePrompts,
    configurable,
    errorMessage,
    isProcessing,
  ];

  HomeState copyWith({
    HomeViewState? viewState,
    List<Prompt>? availablePrompts,
    HomeViewConfigurable? configurable,
    String? errorMessage,
    bool? isProcessing,
  }) {
    return HomeState(
      viewState: viewState ?? this.viewState,
      availablePrompts: availablePrompts ?? this.availablePrompts,
      configurable: configurable ?? this.configurable,
      errorMessage: errorMessage,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class HomeViewModel {
  final _state = ValueNotifier<HomeState>(HomeState.initial());
  final promptManager = PromptManager();

  ValueListenable<HomeState> get state => _state;

  HomeState get currentState => _state.value;

  void updateState(HomeState newState) {
    if (currentState == newState) return;

    DebugLogger.stateChange(
      'HomeViewModel',
      currentState.viewState.name,
      newState.viewState.name,
      data: {
        'hasError': newState.errorMessage != null,
        'isProcessing': newState.isProcessing,
        'promptsCount': newState.availablePrompts.length,
      },
    );

    _state.value = newState;
  }

  void initialize() {
    getAvailablePrompts();
  }

  void getAvailablePrompts() {
    try {
      final prompts = promptManager.getHomePrompts();
      updateState(
        currentState.copyWith(
          viewState: HomeViewState.initial,
          availablePrompts: prompts,
          errorMessage: null,
        ),
      );
    } catch (e) {
      updateState(
        currentState.copyWith(
          viewState: HomeViewState.error,
          errorMessage: 'Failed to load prompts: $e',
        ),
      );
    }
  }

  void reset() {
    updateState(
      currentState.copyWith(
        viewState: HomeViewState.initial,
        configurable: HomeState.initial().configurable,
        errorMessage: null,
      ),
    );
  }

  void callStaticPrompt(String id) {
    try {
      final result = promptManager.callStaticPrompt(id);
      updateState(
        currentState.copyWith(
          viewState: HomeViewState.ready,
          configurable: currentState.configurable?.merge(
            result.configurable.toJson(),
          ),
          errorMessage: null,
        ),
      );
    } catch (e) {
      updateState(
        currentState.copyWith(
          viewState: HomeViewState.error,
          errorMessage: 'Failed to apply prompt: $e',
        ),
      );
    }
  }

  Future<void> callAIPrompt(String userPrompt) async {
    updateState(
      currentState.copyWith(
        viewState: HomeViewState.loading,
        isProcessing: true,
        errorMessage: null,
      ),
    );

    try {
      final result = await promptManager.callAIPrompt(
        userPrompt: userPrompt,
        currentViewConfigurable: currentState.configurable!,
        viewConfigurableSchema: HomeViewConfigurable.schema,
      );

      if (result != null) {
        updateState(
          currentState.copyWith(
            viewState: HomeViewState.ready,
            configurable: currentState.configurable?.merge(result),
            isProcessing: false,
            errorMessage: null,
          ),
        );
      } else {
        throw Exception('AI returned null response');
      }
    } catch (e) {
      updateState(
        currentState.copyWith(
          viewState: HomeViewState.error,
          isProcessing: false,
          errorMessage: 'AI request failed: ${e.toString()}',
        ),
      );
    }
  }

  bool showReset() {
    final initialState = HomeState.initial();
    return currentState.configurable?.toJson().toString() !=
        initialState.configurable?.toJson().toString();
  }
}
