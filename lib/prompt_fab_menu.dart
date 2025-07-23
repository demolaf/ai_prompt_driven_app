import 'package:ai_prompt_driven_app/prompt_input_field.dart';
import 'package:flutter/material.dart';
import 'overlay_manager.dart';

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
    final menuBottomPosition = widget.fabGlobalPosition.dy - 16; // 16px above FAB
    
    return Positioned(
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
                spacing: 32,
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
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Text('Enter custom input'),
                          const Icon(Icons.keyboard),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onMenuSelection();
                    },
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Text('Make the background color red'),
                          const Icon(Icons.info),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onMenuSelection();
                    },
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Text('Make the background color red'),
                          const Icon(Icons.info),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onMenuSelection();
                    },
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Text('Make the background color red'),
                          const Icon(Icons.info),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onMenuSelection();
                    },
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Text('Make the background color red'),
                          const Icon(Icons.info),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onMenuSelection();
                    },
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Text('Make the background color red'),
                          const Icon(Icons.info),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
