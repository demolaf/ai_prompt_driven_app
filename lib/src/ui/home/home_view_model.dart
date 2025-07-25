import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/ui/home/home_view_configurable.dart';
import 'package:ai_prompt_driven_app/src/utils/prompt_manager.dart';
import 'package:flutter/foundation.dart';

enum HomeViewState { initial, loading, ready }

class HomeState {
  HomeState({
    required this.viewState,
    this.availablePrompts = const [],
    this.configurable,
  });

  HomeState.initial()
      : this(
    viewState: HomeViewState.initial,
    availablePrompts: [],
    configurable: HomeViewConfigurable(
      scaffoldConfig: ScaffoldConfig(backgroundColor: 'FFFFFFFF'),
      appBarConfig: AppBarConfig(title: 'Home'),
    ),
  );

  final HomeViewState viewState;
  final List<Prompt> availablePrompts;
  final HomeViewConfigurable? configurable;

  HomeState copyWith({
    required HomeViewState viewState,
    List<Prompt>? availablePrompts,
    HomeViewConfigurable? configurable,
  }) {
    return HomeState(
      viewState: viewState,
      availablePrompts: availablePrompts ?? this.availablePrompts,
      configurable: configurable ?? this.configurable,
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
    _state.value = newState;
  }

  void initialize() {
    getAvailablePrompts();
  }

  void getAvailablePrompts() {
    final prompts = promptManager.getHomePrompts();
    updateState(
      _state.value.copyWith(
        viewState: HomeViewState.initial,
        availablePrompts: prompts,
      ),
    );
  }

  void reset() {
    updateState(HomeState.initial());
  }

  void callStaticPrompt(String id) {
    final result = promptManager.callPrompt(id);
    updateState(
      _state.value.copyWith(
        viewState: HomeViewState.initial,
        configurable: _state.value.configurable?.merge(
          result.configurable.toJson(),
        ),
      ),
    );
  }

  void callAIPrompt(HomeViewConfigurable configurable) {}

  bool showReset() {
    return currentState != HomeState.initial();
  }
}
