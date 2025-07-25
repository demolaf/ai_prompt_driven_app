import 'package:ai_prompt_driven_app/src/model/prompt.dart';
import 'package:ai_prompt_driven_app/src/ui/home/widgets/prompt_fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:ai_prompt_driven_app/src/utils/overlay_manager.dart';

class PromptFAB extends StatefulWidget {
  const PromptFAB({
    required this.onPromptTapped,
    required this.onResetTapped,
    required this.availablePrompts,
    required this.onAskAISubmit,
    super.key,
    this.showReset = false,
    this.isProcessing = false,
  });

  final bool showReset;
  final bool isProcessing;
  final ValueSetter<Prompt> onPromptTapped;
  final ValueSetter<String> onAskAISubmit;
  final VoidCallback onResetTapped;
  final List<Prompt> availablePrompts;

  @override
  State<PromptFAB> createState() => _PromptFABState();
}

class _PromptFABState extends State<PromptFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationAnimationController;
  late Animation<double> _rotationAnimation;

  LayerLink layerLink = LayerLink();
  final OverlayManager _menuOverlay = OverlayManager();

  @override
  void initState() {
    super.initState();

    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 45 / 360).animate(
      CurvedAnimation(
        parent: _rotationAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void didUpdateWidget(PromptFAB oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If showReset changed and menu is visible, update the overlay
    if (oldWidget.showReset != widget.showReset && _menuOverlay.isVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _menuOverlay.isVisible) {
          _menuOverlay.update(
            child: PromptFABMenu(
              onMenuSelection: () {
                hideMenu();
              },
              layerLink: layerLink,
              onPromptTapped: widget.onPromptTapped,
              onResetTapped: widget.onResetTapped,
              sourceWidgetSize: (context.findRenderObject()! as RenderBox).size,
              fabGlobalPosition: (context.findRenderObject()! as RenderBox)
                  .localToGlobal(Offset.zero),
              onDismiss: hideMenu,
              availablePrompts: widget.availablePrompts,
              showReset: widget.showReset,
              onAskAISubmit: widget.onAskAISubmit,
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _menuOverlay.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: FloatingActionButton(
        heroTag: 'PromptFAB',
        onPressed: widget.isProcessing ? null : () {
          if (!_menuOverlay.isVisible) {
            _rotationAnimationController.forward();
            showMenu();
          } else {
            hideMenu();
          }
        },
        backgroundColor: widget.isProcessing ? Colors.grey : null,
        child: widget.isProcessing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : RotationTransition(
                turns: _rotationAnimation,
                child: const Icon(Icons.add),
              ),
      ),
    );
  }

  void showMenu() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    final fabGlobalPosition = renderBox.localToGlobal(Offset.zero);

    _menuOverlay.show(
      context: context,
      child: PromptFABMenu(
        onMenuSelection: () {
          hideMenu();
        },
        layerLink: layerLink,
        onPromptTapped: widget.onPromptTapped,
        onResetTapped: widget.onResetTapped,
        sourceWidgetSize: size,
        fabGlobalPosition: fabGlobalPosition,
        onDismiss: hideMenu,
        availablePrompts: widget.availablePrompts,
        showReset: widget.showReset,
        onAskAISubmit: widget.onAskAISubmit,
      ),
    );
  }

  void hideMenu() {
    _menuOverlay.hide(
      onHide: () {
        _rotationAnimationController.reverse();
      },
    );
  }
}
