import 'package:flutter/material.dart';
import '../utils/overlay_manager.dart';

class PromptInputField extends OverlayWidget {
  const PromptInputField({
    super.key,
    required super.layerLink,
    required super.size,
    super.onDismiss,
    this.onSubmit,
  });

  // TODO(demolaf): add this to the static prompts available
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.7;

  final Function(String)? onSubmit;

  static void show(
    BuildContext context, {
    required LayerLink layerLink,
    required Size size,
    Function(String)? onSubmit,
  }) {
    final overlayManager = OverlayManager();
    
    overlayManager.show(
      context: context,
      child: PromptInputField(
        layerLink: layerLink,
        size: size,
        onSubmit: (text) {
          onSubmit?.call(text);
          overlayManager.hide();
        },
        onDismiss: () => overlayManager.hide(),
      ),
    );
  }

  @override
  State<PromptInputField> createState() => _PromptInputFieldState();
}

class _PromptInputFieldState extends OverlayWidgetState<PromptInputField> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Stack(
        children: [
          ModalBarrier(
            onDismiss: dismiss,
          ),
          CompositedTransformFollower(
            link: widget.layerLink,
            showWhenUnlinked: false,
            offset: Offset(
              -(PromptInputField.width(context) + 16),
              -widget.size.height,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                padding: EdgeInsets.all(16),
                width: PromptInputField.width(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.onSubmit?.call(_textController.text);
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
