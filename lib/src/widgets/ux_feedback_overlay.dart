import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UXFeedbackOverlay extends StatelessWidget {
  const UXFeedbackOverlay({
    required this.isLoading,
    required this.errorMessage,
    required this.child,
    this.onRetry,
    this.loadingMessage = 'Processing...',
    super.key,
  });

  final bool isLoading;
  final String? errorMessage;
  final Widget child;
  final VoidCallback? onRetry;
  final String loadingMessage;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          child,
          if (isLoading) _buildLoadingOverlay(context),
          if (errorMessage != null) _buildErrorOverlay(context),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              const CupertinoActivityIndicator(radius: 16),
              Text(
                loadingMessage,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Please wait while AI processes your request',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorOverlay(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                errorMessage!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: CupertinoButton(
                      onPressed: () {
                        // Dismiss error by calling onRetry without retry logic
                      },
                      child: const Text('Dismiss'),
                    ),
                  ),
                  if (onRetry != null)
                    Expanded(
                      child: CupertinoButton.filled(
                        onPressed: onRetry,
                        child: const Text('Retry'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}