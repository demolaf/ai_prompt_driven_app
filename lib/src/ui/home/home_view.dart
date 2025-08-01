import 'package:ai_prompt_driven_app/src/shared_widgets/dynamic_cupertino_sliver_navigation_bar.dart';
import 'package:ai_prompt_driven_app/src/shared_widgets/dynamic_scaffold.dart';
import 'package:ai_prompt_driven_app/src/ui/home/home_view_model.dart';
import 'package:ai_prompt_driven_app/src/shared_widgets/ux_feedback_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_fab.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/dynamic_greeting_card.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/dynamic_quick_action_grid.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/recent_activity_list.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/dynamic_stat_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.state,
      builder: (context, state, child) {
        return UXFeedbackOverlay(
          isLoading: state.isProcessing,
          errorMessage: state.errorMessage,
          loadingMessage: 'AI is updating your interface...',
          onRetry: () {
            viewModel.initialize();
          },
          child: DynamicScaffold(
            config: state.configurable?.scaffoldConfig,
            body: CustomScrollView(
              slivers: [
                DynamicCupertinoSliverNavigationBar(
                  backgroundColor: Colors.transparent,
                  border: Border.fromBorderSide(BorderSide.none),
                  alwaysShowMiddle: false,
                  config: state.configurable?.appBarConfig,
                  trailing: IconButton(
                    onPressed: () {
                      ProfileView.present(context);
                    },
                    icon: Icon(CupertinoIcons.profile_circled),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverFillRemaining(
                    child: SingleChildScrollView(
                      child: SafeArea(
                        top: false,
                        child: Column(
                          spacing: 24,
                          children: [
                            Container(
                              height: 164,
                              padding: EdgeInsets.only(top: 16),
                              child: PageView(
                                controller: PageController(
                                  viewportFraction: 0.95,
                                ),
                                padEnds: false,
                                children: greetingsList(state),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DynamicStatCard(
                                    config: state.configurable?.statCard1,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: DynamicStatCard(
                                    config: state.configurable?.statCard2,
                                  ),
                                ),
                              ],
                            ),
                            DynamicQuickActionGrid(
                              config: state.configurable?.quickActionConfig,
                              onActionTapped: (action) {
                                // Handle quick action tap
                                // Could integrate with AI or navigation
                              },
                            ),
                            RecentActivityList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: PromptFAB(
              showReset: viewModel.showReset(),
              isProcessing: state.isProcessing,
              onAskAISubmit: (prompt) {
                viewModel.callAIPrompt(prompt);
              },
              onPromptTapped: (prompt) {
                viewModel.callStaticPrompt(prompt.id);
              },
              onResetTapped: () {
                viewModel.reset();
              },
              availablePrompts: state.availablePrompts,
            ),
          ),
        );
      },
    );
  }

  List<DynamicGreetingCard> greetingsList(HomeState state) {
    final greetings =
        state.configurable?.greetingCardConfig?.greetingsList ?? [];
    return greetings.asMap().entries.map((entry) {
      final isLastItem = entry.key == greetings.length - 1;
      return DynamicGreetingCard(
        data: entry.value,
        isLastItem: isLastItem,
        config: state.configurable?.greetingCardConfig,
      );
    }).toList();
  }
}
