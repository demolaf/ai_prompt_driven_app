import 'dart:developer' as developer;
import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view_configurable.dart';
import 'package:ai_prompt_driven_app/src/utils/prompt_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum ProfileViewState { initial, loading, ready }

class ProfileState extends Equatable {
  const ProfileState({
    required this.viewState,
    this.availablePrompts = const [],
    this.configurable,
  });

  ProfileState.initial()
    : this(
        viewState: ProfileViewState.initial,
        availablePrompts: [],
        configurable: ProfileViewConfigurable(
          scaffoldConfig: ScaffoldConfig(backgroundColor: 'FFFFFFFF'),
          appBarConfig: AppBarConfig(title: 'Profile'),
        ),
      );

  final ProfileViewState viewState;
  final List<Prompt> availablePrompts;
  final ProfileViewConfigurable? configurable;

  @override
  List<Object?> get props => [viewState, availablePrompts, configurable];

  ProfileState copyWith({
    required ProfileViewState viewState,
    List<Prompt>? availablePrompts,
    ProfileViewConfigurable? configurable,
  }) {
    return ProfileState(
      viewState: viewState,
      availablePrompts: availablePrompts ?? this.availablePrompts,
      configurable: configurable ?? this.configurable,
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
    _state.value = newState;
  }

  void initialize() {
    getAvailablePrompts();
  }

  void getAvailablePrompts() {
    final prompts = promptManager.getProfilePrompts();
    updateState(
      _state.value.copyWith(
        viewState: ProfileViewState.initial,
        availablePrompts: prompts,
      ),
    );
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
    updateState(currentState.copyWith(viewState: ProfileViewState.loading));

    try {
      final result = await promptManager.callAIPrompt(
        userPrompt: userPrompt,
        viewConfigurableSchema: ProfileViewConfigurable.schema,
      );

      updateState(
        currentState.copyWith(
          viewState: ProfileViewState.ready,
          configurable: currentState.configurable?.merge(result),
        ),
      );
    } catch (e) {
      developer.log('Error calling AI prompt: $e', name: 'ProfileViewModel');
      updateState(currentState.copyWith(viewState: ProfileViewState.initial));
    }
  }

  bool showReset() {
    final initialState = ProfileState.initial();
    return currentState.configurable?.toJson().toString() !=
        initialState.configurable?.toJson().toString();
  }
}
