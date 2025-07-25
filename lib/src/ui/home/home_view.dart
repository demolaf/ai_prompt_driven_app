import 'package:ai_prompt_driven_app/src/ui/home/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_prompt_driven_app/src/model/greeting_model.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_fab.dart';
import 'package:ai_prompt_driven_app/src/widgets/dynamic_scaffold.dart';
import 'package:ai_prompt_driven_app/src/widgets/dynamic_cupertino_sliver_navigation_bar.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/greeting_card.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/quick_action_grid.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/recent_activity_list.dart';
import 'package:ai_prompt_driven_app/src/widgets/dynamic_stat_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final viewModel = HomeViewModel();

  ValueNotifier<List<GreetingModel>> greetingsList = ValueNotifier(
    GreetingModel.getPlaceholderData,
  );

  @override
  void initState() {
    viewModel.initialize();
    super.initState();
  }

  @override
  void dispose() {
    greetingsList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.state,
      builder: (context, state, child) {
        return DynamicScaffold(
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
                              children: greetingsList.value
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => GreetingCard(
                                      data: entry.value,
                                      isLastItem:
                                          entry.key ==
                                          greetingsList.value.length - 1,
                                    ),
                                  )
                                  .toList(),
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
                          QuickActionGrid(),
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
        );
      },
    );
  }
}
