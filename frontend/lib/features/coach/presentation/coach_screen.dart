// lib/features/coach/presentation/coach_screen.dart
// Waketale v2 — AI Coach chat + CBT-I program stages.
// Groq Llama via Supabase Edge Function (ai-coach). Longitudinal memory.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/network/supabase_client.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/premium_gate.dart';

part 'coach_screen.g.dart';

// ─── Providers ────────────────────────────────────────────────────────────────

@riverpod
Future<int> cbtiWeek(Ref ref) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return 1;
  final data = await SupabaseClientService.client
      .from('profiles')
      .select('cbti_week')
      .eq('id', userId)
      .maybeSingle();
  final week = data?['cbti_week'] as int?;
  return week ?? 1;
}

class _ChatMessage {
  const _ChatMessage({required this.content, required this.isUser, required this.timestamp});
  final String content;
  final bool isUser;
  final DateTime timestamp;
}

class CoachScreen extends ConsumerStatefulWidget {
  const CoachScreen({super.key});

  @override
  ConsumerState<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends ConsumerState<CoachScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(
        content: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isSending = true;
      _controller.clear();
    });
    _scrollToBottom();

    try {
      final accessToken =
          Supabase.instance.client.auth.currentSession?.accessToken;
      final response = await SupabaseClientService.client.functions.invoke(
        SupabaseClientService.fnAiCoach,
        headers: accessToken != null
            ? {'Authorization': 'Bearer $accessToken'}
            : null,
        body: {
          'message': text,
          'history': _messages
              .where((m) => !m.isUser || m.content != text)
              .take(10)
              .map((m) => {
                    'role': m.isUser ? 'user' : 'assistant',
                    'content': m.content,
                  })
              .toList(),
        },
      );

      final reply = response.data?['reply'] as String? ??
          'Sorry, I couldn\'t generate a response. Please try again.';

      if (mounted) {
        setState(() {
          _messages.add(_ChatMessage(
            content: reply,
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('[Coach] Edge Function error: $e');
      if (mounted) {
        final s = S.of(context);
        setState(() {
          _messages.add(_ChatMessage(
            content: s.errorAiCoach,
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s.coachTitle)),
      body: PremiumGate(
        featureName: s.coachTitle,
        child: Column(
          children: [
            // ── CBT-I stage banner ──────────────────────────────────────────
            _CbtiStageBanner(s: s),

            // ── Chat messages ───────────────────────────────────────────────
            Expanded(
              child: _messages.isEmpty
                  ? _EmptyCoach(s: s)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(AppTheme.md),
                      itemCount: _messages.length + (_isSending ? 1 : 0),
                      itemBuilder: (context, i) {
                        if (i == _messages.length) {
                          return const RepaintBoundary(child: _TypingIndicator());
                        }
                        return _MessageBubble(message: _messages[i]);
                      },
                    ),
            ),

            // ── Input bar ───────────────────────────────────────────────────
            _InputBar(
              controller: _controller,
              isSending: _isSending,
              s: s,
              onSend: _send,
            ),
          ],
        ),
      ),
    );
  }
}

class _CbtiStageBanner extends ConsumerWidget {
  const _CbtiStageBanner({required this.s});
  final S s;

  String _weekLabel(int week, S s) {
    if (week <= 1) return s.cbtiWeek1;
    if (week == 2) return s.cbtiWeek2;
    if (week == 3) return s.cbtiWeek3;
    if (week == 4) return s.cbtiWeek4;
    if (week == 5) return s.cbtiWeek5;
    if (week == 6) return s.cbtiWeek6;
    if (week == 7) return s.cbtiWeek7;
    return s.cbtiWeek8;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekAsync = ref.watch(cbtiWeekProvider);
    final weekLabel = weekAsync.when(
      data: (week) => _weekLabel(week, s),
      loading: () => s.cbtiWeek1,
      error: (e, st) => s.cbtiWeek1,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.md, vertical: AppTheme.sm),
      color: AppTheme.bgMid,
      child: Row(
        children: [
          const Icon(Icons.auto_graph, size: 16, color: AppTheme.primary),
          const SizedBox(width: AppTheme.xs),
          Text(
            s.coachProgramStage,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.primary,
                ),
          ),
          const Spacer(),
          Text(
            weekLabel,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _EmptyCoach extends StatelessWidget {
  const _EmptyCoach({required this.s});
  final S s;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🧠', style: TextStyle(fontSize: 56)),
            const SizedBox(height: AppTheme.md),
            Text(s.emptyCoachTitle,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: AppTheme.sm),
            Text(s.emptyCoachBody,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});
  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.md,
          vertical: AppTheme.sm,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? AppTheme.primary : AppTheme.bgSurface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppTheme.radiusMd),
            topRight: const Radius.circular(AppTheme.radiusMd),
            bottomLeft: Radius.circular(isUser ? AppTheme.radiusMd : 4),
            bottomRight: Radius.circular(isUser ? 4 : AppTheme.radiusMd),
          ),
        ),
        child: Text(
          message.content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isUser ? AppTheme.textPrimary : AppTheme.textPrimary,
              ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.md,
          vertical: AppTheme.sm,
        ),
        decoration: BoxDecoration(
          color: AppTheme.bgSurface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: const SizedBox(
          width: 40,
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Dot(delay: 0),
              _Dot(delay: 200),
              _Dot(delay: 400),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  const _Dot({required this.delay});
  final int delay;

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat(reverse: true);
    });
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: const CircleAvatar(
        radius: 4,
        backgroundColor: AppTheme.textHint,
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.isSending,
    required this.s,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isSending;
  final S s;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppTheme.md),
        color: AppTheme.bgMid,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSend(),
                enabled: !isSending,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: s.coachMessageHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppTheme.bgSurface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.md,
                    vertical: AppTheme.sm,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.sm),
            GestureDetector(
              onTap: isSending ? null : onSend,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSending ? AppTheme.bgBorder : AppTheme.primary,
                ),
                child: isSending
                    ? const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      )
                    : const Icon(
                        Icons.send_rounded,
                        color: AppTheme.textPrimary,
                        size: 20,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
