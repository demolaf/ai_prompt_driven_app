import 'package:ai_prompt_driven_app/src/dynamic_widgets/dynamic_cupertino_sliver_navigation_bar.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_fab.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view_model.dart';
import 'package:ai_prompt_driven_app/src/dynamic_widgets/dynamic_scaffold.dart';
import 'package:ai_prompt_driven_app/src/widgets/ux_feedback_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_prompt_driven_app/src/dynamic_widgets/dynamic_profile_header.dart';
import 'package:ai_prompt_driven_app/src/dynamic_widgets/dynamic_stats_section.dart';
import 'package:ai_prompt_driven_app/src/dynamic_widgets/dynamic_settings_section.dart';

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
        return UXFeedbackOverlay(
          isLoading: state.isProcessing,
          errorMessage: state.errorMessage,
          loadingMessage: 'AI is updating your profile...',
          onRetry: () {
            viewModel.initialize();
          },
          child: DynamicScaffold(
            config: state.configurable?.scaffoldConfig,
            body: CustomScrollView(
              slivers: [
                DynamicCupertinoSliverNavigationBar(
                  config: state.configurable?.appBarConfig,
                  backgroundColor: Colors.transparent,
                  border: Border.fromBorderSide(BorderSide.none),
                  alwaysShowMiddle: false,
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
                            DynamicProfileHeader(
                              config: state.configurable?.profileHeaderConfig,
                              onAvatarTapped: () {
                                // Handle avatar tap - could open image picker
                              },
                            ),
                            DynamicStatsSection(
                              config: state.configurable?.statsSectionConfig,
                            ),
                            DynamicSettingsSection(
                              config: state.configurable?.settingsSectionConfig,
                              onSettingChanged: (id, value) {
                                // Handle setting changes here
                              },
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
}
