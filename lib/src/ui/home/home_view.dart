import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/greeting_model.dart';
import '../profile/profile_view.dart';
import '../../widgets/prompt_fab.dart';
import '../../widgets/greeting_card.dart';
import '../../widgets/quick_action_grid.dart';
import '../../widgets/recent_activity_list.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/dynamic_scaffold.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ValueNotifier<List<GreetingModel>> greetingsList = ValueNotifier(
    GreetingModel.getPlaceholderData,
  );

  Map<String, dynamic> scaffoldConfig = {'backgroundColor': '#ffffff'};

  @override
  void dispose() {
    greetingsList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
      config: scaffoldConfig,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: Colors.transparent,
            border: Border.fromBorderSide(BorderSide.none),
            alwaysShowMiddle: false,
            largeTitle: Text('Home'),
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
                          controller: PageController(viewportFraction: 0.95),
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
                            child: StatCard(
                              title: 'Total Conversations',
                              value: '1,247',
                              icon: CupertinoIcons.chat_bubble_2,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: StatCard(
                              title: 'Languages Supported',
                              value: '95+',
                              icon: CupertinoIcons.globe,
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
      floatingActionButton: PromptFAB(),
    );
  }
}
