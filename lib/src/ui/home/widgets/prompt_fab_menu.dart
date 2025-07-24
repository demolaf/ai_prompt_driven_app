import 'package:ai_prompt_driven_app/src/utils/overlay_manager.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_input_field.dart';
import 'package:flutter/material.dart';

class PromptFABMenu extends OverlayWidget {
  const PromptFABMenu({
    super.key,
    required super.sourceWidgetSize,
    super.onDismiss,
    required this.onMenuSelection,
    required this.fabGlobalPosition,
  });

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.3;

  final VoidCallback onMenuSelection;
  final Offset fabGlobalPosition;

  @override
  State<PromptFABMenu> createState() => _PromptFABMenuState();
}

class _PromptFABMenuState extends OverlayWidgetState<PromptFABMenu> {
  @override
  void initializeAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    final menuBottomPosition = widget.fabGlobalPosition.dy - 16;

    return Stack(
      children: [
        ModalBarrier(onDismiss: dismiss),
        Positioned(
          bottom: MediaQuery.sizeOf(context).height - menuBottomPosition,
          right: 0,
          child: FadeTransition(
            opacity: animation,
            child: FABMenuContent(
              onMenuSelection: widget.onMenuSelection,
              onAskAI: () {
                widget.onMenuSelection();
                PromptInputField.show(
                  context,
                  layerLink: widget.layerLink,
                  size: widget.sourceWidgetSize,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class FABMenuContent extends StatelessWidget {
  const FABMenuContent({
    super.key,
    required this.onMenuSelection,
    required this.onAskAI,
  });

  final VoidCallback onMenuSelection;
  final VoidCallback onAskAI;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMenuSelection,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 24,
            children: [
              GestureDetector(
                onTap: onAskAI,
                child: FABMenuItem(title: 'Ask AI', icon: Icon(Icons.keyboard)),
              ),
              GestureDetector(
                onTap: onMenuSelection,
                child: FABMenuItem(
                  title: 'Make the background blue',
                  icon: Icon(Icons.diamond),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FABMenuItem extends StatelessWidget {
  const FABMenuItem({super.key, required this.title, required this.icon});

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 16,
            children: [Text(title), icon],
          ),
        ),
      ),
    );
  }
}
