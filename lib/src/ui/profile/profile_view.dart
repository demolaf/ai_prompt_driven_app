import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_fab.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view_model.dart';
import 'package:ai_prompt_driven_app/src/widgets/dynamic_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/widgets/profile_header.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/widgets/stats_section.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/widgets/settings_section.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static void present(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (context) {
          return ProfileView();
        },
      ),
    );
  }

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel viewModel = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProfileState>(
      valueListenable: viewModel.state,
      builder: (context, state, child) {
        return DynamicScaffold(
          config: state.configurable?.scaffoldConfig,
          body: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                backgroundColor: Colors.transparent,
                border: Border.fromBorderSide(BorderSide.none),
                alwaysShowMiddle: false,
                largeTitle: Text('Profile'),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverFillRemaining(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      top: false,
                      child: Column(
                        spacing: 32,
                        children: [
                          ProfileHeader(),
                          StatsSection(),
                          SettingsSection(
                            darkModeEnabled:
                                state.configurable?.darkModeEnabled ?? false,
                            onDarkModeChanged: (value) =>
                                viewModel.updateDarkMode(value),
                          ),
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
