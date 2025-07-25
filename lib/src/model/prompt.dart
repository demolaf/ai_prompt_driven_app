import 'package:ai_prompt_driven_app/src/model/appbar_config.dart';
import 'package:ai_prompt_driven_app/src/model/scaffold_config.dart';
import 'package:ai_prompt_driven_app/src/model/view_configurable.dart';
import 'package:ai_prompt_driven_app/src/ui/home/home_view_configurable.dart';
import 'package:ai_prompt_driven_app/src/ui/profile/profile_view_configurable.dart';
import 'package:equatable/equatable.dart';

class Prompt extends Equatable {
  const Prompt({required this.id, required this.title, required this.configurable});

  final String id;
  final String title;
  final ViewConfigurable configurable;

  @override
  List<Object?> get props => [id, title, configurable];

  static List<Prompt> get allPrompts {
    return [...homePrompts, ...profilePrompts];
  }

  static List<Prompt> get homePrompts {
    return [
      Prompt(
        id: '121',
        title: 'Make background blue',
        configurable: HomeViewConfigurable(
          scaffoldConfig: ScaffoldConfig(backgroundColor: 'FF00008B'),
        ),
      ),
      Prompt(
        id: '221',
        title: 'Change the app bar title to Dashboard',
        configurable: HomeViewConfigurable(
          appBarConfig: AppBarConfig(title: 'Dashboard'),
        ),
      ),
    ];
  }

  static List<Prompt> get profilePrompts {
    return [
      Prompt(
        id: '123',
        title: 'Make background red',
        configurable: ProfileViewConfigurable(
          scaffoldConfig: ScaffoldConfig(backgroundColor: 'FF8B0000'),
          appBarConfig: AppBarConfig(title: 'Profile'),
        ),
      ),
    ];
  }
}
