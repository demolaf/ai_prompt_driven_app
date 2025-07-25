import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view_configurable.dart';
import 'package:ai_prompt_driven_app/src/utils/prompt_manager.dart';
import 'package:ai_prompt_driven_app/src/utils/debug_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum ProfileViewState { initial, loading, ready, error }

class ProfileState extends Equatable {
  const ProfileState({
    required this.viewState,
    this.availablePrompts = const [],
    this.configurable,
    this.errorMessage,
    this.isProcessing = false,
  });

  ProfileState.initial()
    : this(
        viewState: ProfileViewState.initial,
        availablePrompts: [],
        configurable: ProfileViewConfigurable.initial(),
      );

  final ProfileViewState viewState;
  final List<Prompt> availablePrompts;
  final ProfileViewConfigurable? configurable;
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

  ProfileState copyWith({
    ProfileViewState? viewState,
    List<Prompt>? availablePrompts,
    ProfileViewConfigurable? configurable,
    String? errorMessage,
    bool? isProcessing,
  }) {
    return ProfileState(
      viewState: viewState ?? this.viewState,
      availablePrompts: availablePrompts ?? this.availablePrompts,
      configurable: configurable ?? this.configurable,
      errorMessage: errorMessage,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class ProfileViewModel {
  final _state = ValueNotifier<ProfileState>(ProfileState.initial());
  final promptManager = PromptManager();

  ValueListenable<ProfileState> get state => _state;

  ProfileState get currentState => _state.value;

  void updateState(ProfileState newState) {
    if (currentState == newState) return;

    DebugLogger.stateChange(
      'ProfileViewModel',
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
      final prompts = promptManager.getProfilePrompts();
      updateState(
        _state.value.copyWith(
          viewState: ProfileViewState.initial,
          availablePrompts: prompts,
          errorMessage: null,
        ),
      );
    } catch (e) {
      updateState(
        _state.value.copyWith(
          viewState: ProfileViewState.error,
          errorMessage: 'Failed to load prompts: $e',
        ),
      );
    }
  }

  void reset() {
    updateState(
      currentState.copyWith(
        viewState: ProfileViewState.initial,
        configurable: ProfileState.initial().configurable,
      ),
    );
  }

  void callStaticPrompt(String id) {
    final result = promptManager.callStaticPrompt(id);
    updateState(
      _state.value.copyWith(
        viewState: ProfileViewState.initial,
        configurable: _state.value.configurable?.merge(
          result.configurable.toJson(),
        ),
      ),
    );
  }

  Future<void> callAIPrompt(String userPrompt) async {
    updateState(
      currentState.copyWith(
        viewState: ProfileViewState.loading,
        isProcessing: true,
        errorMessage: null,
      ),
    );

    try {
      final result = await promptManager.callAIPrompt(
        userPrompt: userPrompt,
        currentViewConfigurable: currentState.configurable!,
        viewConfigurableSchema: ProfileViewConfigurable.schema,
      );

      if (result != null) {
        updateState(
          currentState.copyWith(
            viewState: ProfileViewState.ready,
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
          viewState: ProfileViewState.error,
          isProcessing: false,
          errorMessage: 'AI request failed: ${e.toString()}',
        ),
      );
    }
  }

  bool showReset() {
    final initialState = ProfileState.initial();
    return currentState.configurable?.toJson().toString() !=
        initialState.configurable?.toJson().toString();
  }
}
