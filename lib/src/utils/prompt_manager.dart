import 'package:ai_prompt_driven_app/src/model/prompt.dart';

class PromptManager {
  List<Prompt> getHomePrompts() {
    return Prompt.homePrompts;
  }

  List<Prompt> getProfilePrompts() {
    return Prompt.profilePrompts;
  }

  Prompt callPrompt(String id) {
    return Prompt.allPrompts.firstWhere((e) => e.id == id);
  }
}
