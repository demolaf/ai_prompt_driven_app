import 'prompt_input_field.dart';
import 'package:flutter/material.dart';
import '../utils/overlay_manager.dart';

class PromptFABMenu extends OverlayWidget {
  const PromptFABMenu({
    super.key,
    required super.layerLink,
    required super.size,
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
    // Calculate menu position from top of screen based on FAB's actual position
    final menuBottomPosition =
        widget.fabGlobalPosition.dy - 16; // 16px above FAB

    return Stack(
      children: [
        ModalBarrier(
          onDismiss: dismiss,
        ),
        Positioned(
          bottom: MediaQuery.sizeOf(context).height - menuBottomPosition,
          right: 16, // Same right margin as FAB
          child: FadeTransition(
            opacity: animation,
            child: GestureDetector(
              onTap: widget.onMenuSelection,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 24,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widget.onMenuSelection();
                          PromptInputField.show(
                            context,
                            layerLink: widget.layerLink,
                            size: widget.size,
                          );
                        },
                        child: FABMenuItem(
                          title: 'Enter custom input',
                          icon: Icon(Icons.keyboard),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onMenuSelection();
                        },
                        child: FABMenuItem(
                          title: 'Translate text',
                          icon: Icon(Icons.translate),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onMenuSelection();
                        },
                        child: FABMenuItem(
                          title: 'Summarize content',
                          icon: Icon(Icons.summarize),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onMenuSelection();
                        },
                        child: FABMenuItem(
                          title: 'Generate code',
                          icon: Icon(Icons.code),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onMenuSelection();
                        },
                        child: FABMenuItem(
                          title: 'Write email',
                          icon: Icon(Icons.email),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onMenuSelection();
                        },
                        child: FABMenuItem(
                          title: 'Answer questions',
                          icon: Icon(Icons.help_outline),
                        ),
                      ),
                    ],
                  ),
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
