import 'package:ai_prompt_driven_app/profile_view.dart';
import 'package:ai_prompt_driven_app/prompt_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
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
              sliver: SliverFillRemaining(child: Column(children: [])),
            ),
          ],
        ),
      ),
      floatingActionButton: PromptFAB(),
    );
  }
}
