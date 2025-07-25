import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/ui/home/home_view_configurable.dart';
import 'package:ai_prompt_driven_app/src/utils/prompt_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum HomeViewState { initial, loading, ready }

class HomeState extends Equatable {
  const HomeState({
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

  @override
  List<Object?> get props => [viewState, availablePrompts, configurable];

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
      currentState.copyWith(
        viewState: HomeViewState.initial,
        availablePrompts: prompts,
      ),
    );
  }

  void reset() {
    updateState(
      currentState.copyWith(
        viewState: HomeViewState.initial,
        configurable: HomeState.initial().configurable,
      ),
    );
  }

  void callStaticPrompt(String id) {
    final result = promptManager.callStaticPrompt(id);
    updateState(
      currentState.copyWith(
        viewState: HomeViewState.initial,
        configurable: currentState.configurable?.merge(
          result.configurable.toJson(),
        ),
      ),
    );
  }

  Future<void> callAIPrompt(String userPrompt) async {
    updateState(currentState.copyWith(viewState: HomeViewState.loading));

    try {
      final result = await promptManager.callAIPrompt(
        userPrompt: userPrompt,
        currentViewConfigurable: currentState.configurable,
      );

      if (result == null) {
        return;
      }

      updateState(
        currentState.copyWith(
          viewState: HomeViewState.ready,
          configurable: HomeViewConfigurable.fromJson(result),
        ),
      );
    } catch (e) {
      updateState(currentState.copyWith(viewState: HomeViewState.initial));
    }
  }

  bool showReset() {
    final initialState = HomeState.initial();
    return currentState.configurable?.toJson().toString() !=
        initialState.configurable?.toJson().toString();
  }
}
