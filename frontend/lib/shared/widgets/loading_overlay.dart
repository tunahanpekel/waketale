// lib/shared/widgets/loading_overlay.dart
// Waketale v2 — Full-screen loading overlay with rotating messages.

import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    super.key,
    this.messages = const [],
  });

  final List<String> messages;

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  int _msgIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.messages.length > 1) {
      _rotate();
    }
  }

  void _rotate() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _msgIndex = (_msgIndex + 1) % widget.messages.length;
      });
      _rotate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bgDeep.withValues(alpha: 0.85),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppTheme.primary,
              strokeWidth: 2.5,
            ),
            if (widget.messages.isNotEmpty) ...[
              const SizedBox(height: AppTheme.lg),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  widget.messages[_msgIndex],
                  key: ValueKey(_msgIndex),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Wraps child with an overlay when [isLoading] is true.
class LoadingWrapper extends StatelessWidget {
  const LoadingWrapper({
    super.key,
    required this.isLoading,
    required this.child,
    this.messages = const [],
  });

  final bool isLoading;
  final Widget child;
  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) LoadingOverlay(messages: messages),
      ],
    );
  }
}
