import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/utils/widget_parser.dart';
import 'package:flutter/material.dart';

class DynamicScaffold extends Scaffold {
  const DynamicScaffold({
    super.key,
    super.body,
    super.floatingActionButton,
    this.config,
  });

  final ScaffoldConfig? config;

  @override
  Color? get backgroundColor {
    return WidgetParser.parseColor(config?.backgroundColor);
  }
}
