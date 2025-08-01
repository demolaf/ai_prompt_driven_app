import 'package:flutter/material.dart';

class OverlayManager {
  OverlayEntry? _entry;
  bool _isVisible = false;
  Widget? _currentChild;

  bool get isVisible => _isVisible;

  void show({
    required BuildContext context,
    required Widget child,
    VoidCallback? onHide,
  }) {
    if (_isVisible) return;

    final overlay = Overlay.of(context);
    _currentChild = child;

    _entry = OverlayEntry(builder: (context) => _currentChild!);

    overlay.insert(_entry!);
    _isVisible = true;
  }

  void update({required Widget child}) {
    if (!_isVisible || _entry == null) return;

    _currentChild = child;
    _entry!.markNeedsBuild();
  }

  void hide({VoidCallback? onHide}) {
    if (!_isVisible) return;

    _entry?.remove();
    _entry = null;
    _currentChild = null;
    _isVisible = false;
    onHide?.call();
  }

  void dispose() {
    hide();
  }
}

abstract class OverlayWidget extends StatefulWidget {
  const OverlayWidget({
    required this.sourceWidgetSize,
    required this.layerLink,
    super.key,
    this.onDismiss,
  });

  final Size sourceWidgetSize;
  final LayerLink layerLink;
  final VoidCallback? onDismiss;
}

abstract class OverlayWidgetState<T extends OverlayWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    initializeAnimation();
    animationController.forward();
  }

  void initializeAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void dismiss() {
    if (mounted) {
      animationController.reverse().then((_) {
        widget.onDismiss?.call();
      });
    }
  }

  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => buildContent(context),
    );
  }
}
