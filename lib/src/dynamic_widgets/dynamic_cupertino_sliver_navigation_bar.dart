import 'package:ai_prompt_driven_app/src/config/appbar_config.dart';
import 'package:flutter/cupertino.dart';

class DynamicCupertinoSliverNavigationBar extends CupertinoSliverNavigationBar {
  const DynamicCupertinoSliverNavigationBar({
    super.key,
    super.backgroundColor,
    super.border,
    super.alwaysShowMiddle,
    super.trailing,
    super.previousPageTitle,
    super.middle,
    super.leading,
    super.automaticallyImplyLeading,
    super.automaticallyImplyTitle,
    super.stretch,
    this.config,
  });

  final AppBarConfig? config;

  @override
  Widget? get largeTitle {
    if (config?.title != null) {
      return Text(config!.title);
    }
    return super.largeTitle;
  }

  @override
  Widget? get middle {
    if (config?.title != null && super.middle == null) {
      return Text(config!.title);
    }
    return super.middle;
  }
}
