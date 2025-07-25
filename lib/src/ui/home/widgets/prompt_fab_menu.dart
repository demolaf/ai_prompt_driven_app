import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/utils/overlay_manager.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_input_field.dart';
import 'package:flutter/material.dart';

class PromptFABMenu extends OverlayWidget {
  const PromptFABMenu({
    required super.layerLink,
    required super.sourceWidgetSize,
    required this.onMenuSelection,
    required this.onPromptTapped,
    required this.onResetTapped,
    required this.availablePrompts,
    required this.fabGlobalPosition,
    required this.onAskAISubmit,
    this.showReset = false,
    super.key,
    super.onDismiss,
  });

  final VoidCallback onMenuSelection;
  final ValueSetter<Prompt> onPromptTapped;
  final VoidCallback onResetTapped;
  final ValueSetter<String> onAskAISubmit;
  final List<Prompt> availablePrompts;
  final Offset fabGlobalPosition;
  final bool showReset;

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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 24,
                  children: [
                    FABMenuItem(
                      onTap: () {
                        // widget.onMenuSelection();
                        PromptInputField.show(
                          context,
                          layerLink: widget.layerLink,
                          size: widget.sourceWidgetSize,
                          onSubmit: widget.onAskAISubmit,
                        );
                      },
                      title: 'Ask AI',
                      icon: Icon(Icons.keyboard),
                    ),
                    if (widget.showReset)
                      FABMenuItem(
                        onTap: () {
                          // widget.onMenuSelection();
                          widget.onResetTapped();
                        },
                        title: 'Reset changes',
                        icon: Icon(Icons.restart_alt),
                      ),
                    ...widget.availablePrompts.map((e) {
                      return FABMenuItem(
                        onTap: () {
                          // widget.onMenuSelection();
                          widget.onPromptTapped(e);
                        },
                        title: e.title,
                        icon: Icon(Icons.diamond),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FABMenuItem extends StatelessWidget {
  const FABMenuItem({
    required this.onTap,
    required this.title,
    required this.icon,
    super.key,
  });

  final VoidCallback onTap;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
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
      ),
    );
  }
}
