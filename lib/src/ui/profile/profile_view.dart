import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_fab.dart';
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
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return DynamicScaffold(
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
                        darkModeEnabled: _darkModeEnabled,
                        onDarkModeChanged: (value) =>
                            setState(() => _darkModeEnabled = value),
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
        onPromptTapped: (value) {},
        availablePrompts: [],
      ),
    );
  }
}
