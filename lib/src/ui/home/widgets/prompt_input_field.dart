import 'package:flutter/material.dart';
import 'package:ai_prompt_driven_app/src/utils/overlay_manager.dart';
import 'package:ai_prompt_driven_app/src/utils/debug_logger.dart';

class PromptInputField extends OverlayWidget {
  const PromptInputField({
    required super.layerLink,
    required super.sourceWidgetSize,
    super.key,
    super.onDismiss,
    this.onSubmit,
  });

  final ValueSetter<String>? onSubmit;

  static void show(
    BuildContext context, {
    required LayerLink layerLink,
    required Size size,
    Function(String)? onSubmit,
  }) {
    DebugLogger.userAction(
      'show_prompt_input',
      data: {'hasOnSubmit': onSubmit != null},
    );

    final overlayManager = OverlayManager();

    overlayManager.show(
      context: context,
      child: PromptInputField(
        layerLink: layerLink,
        sourceWidgetSize: size,
        onSubmit: (text) {
          DebugLogger.userAction(
            'prompt_input_submit',
            data: {
              'textLength': text.length,
              'text': text.substring(0, text.length > 50 ? 50 : text.length),
            },
          );
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
          ModalBarrier(onDismiss: dismiss),
          CompositedTransformFollower(
            link: widget.layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.bottomRight,
            offset: Offset(-16, 0),
            child: Material(
              type: MaterialType.transparency,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return PromptInputContent(
                    maxWidth:
                        constraints.maxWidth -
                        widget.sourceWidgetSize.width -
                        48,
                    textController: _textController,
                    focusNode: _focusNode,
                    onSubmit: () {
                      final text = _textController.text.trim();
                      if (text.isNotEmpty) {
                        DebugLogger.debug('Calling widget.onSubmit with text');
                        widget.onSubmit?.call(_textController.text);
                      } else {
                        DebugLogger.warning('Text is empty, not submitting');
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromptInputContent extends StatelessWidget {
  const PromptInputContent({
    required this.maxWidth,
    required this.textController,
    required this.focusNode,
    required this.onSubmit,
    super.key,
  });

  final double maxWidth;
  final TextEditingController textController;
  final FocusNode focusNode;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      constraints: BoxConstraints(maxWidth: maxWidth),
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
          PromptTextInput(
            textController: textController,
            focusNode: focusNode,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}

class PromptTextInput extends StatelessWidget {
  const PromptTextInput({
    required this.textController,
    required this.focusNode,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController textController;
  final FocusNode focusNode;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              focusNode: focusNode,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 1,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type your message here...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
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
                onTap: onSubmit,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
