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
              -(widget.size.height + 100),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      'Ask AI',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
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
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type your message here...',
                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Material(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  if (_textController.text.trim().isNotEmpty) {
                                    widget.onSubmit?.call(_textController.text);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
