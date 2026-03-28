// lib/features/settings/presentation/wearables_settings_screen.dart
// Waketale v2 — Wearables / Health Data Settings sub-screen.
// Lets the user connect Apple Health (iOS) or Google Fit / Health Connect (Android),
// view sync status, and trigger a manual sync.
// Persists appleHealthEnabled / googleFitEnabled to Supabase profiles table.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/network/supabase_client.dart';
import '../../../core/services/health_service.dart';
import '../../../core/theme/app_theme.dart';

// ─── Screen ───────────────────────────────────────────────────────────────────

class WearablesSettingsScreen extends ConsumerStatefulWidget {
  const WearablesSettingsScreen({super.key});

  @override
  ConsumerState<WearablesSettingsScreen> createState() =>
      _WearablesSettingsScreenState();
}

class _WearablesSettingsScreenState
    extends ConsumerState<WearablesSettingsScreen> {
  bool _appleHealthEnabled = false;
  bool _googleFitEnabled = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentValues();
  }

  Future<void> _loadCurrentValues() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;
      final row = await SupabaseClientService.client
          .from(SupabaseClientService.tableUsers)
          .select('apple_health_enabled, google_fit_enabled')
          .eq('id', userId)
          .maybeSingle();
      if (row == null) return;
      if (mounted) {
        setState(() {
          _appleHealthEnabled =
              (row['apple_health_enabled'] as bool?) ?? false;
          _googleFitEnabled =
              (row['google_fit_enabled'] as bool?) ?? false;
        });
      }
    } catch (e) {
      debugPrint('[WearablesSettings] _loadCurrentValues error: $e');
    }
  }

  Future<void> _saveToSupabase({
    required bool appleHealth,
    required bool googleFit,
  }) async {
    setState(() => _isSaving = true);
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId == null) return;
      await SupabaseClientService.client
          .from(SupabaseClientService.tableUsers)
          .update({
            'apple_health_enabled': appleHealth,
            'google_fit_enabled': googleFit,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
    } catch (e) {
      debugPrint('[WearablesSettings] _saveToSupabase error: $e');
      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.errorGenericBody),
          backgroundColor: AppTheme.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _onToggleAppleHealth(bool value) async {
    if (value) {
      // Request permissions first
      final granted =
          await ref.read(healthServiceProvider).requestPermissions();
      if (!granted) {
        if (mounted) {
          final s = S.of(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(s.wearablePermission),
            backgroundColor: AppTheme.warning,
          ));
        }
        return;
      }
    }
    setState(() => _appleHealthEnabled = value);
    await _saveToSupabase(
      appleHealth: value,
      googleFit: _googleFitEnabled,
    );
  }

  Future<void> _onToggleGoogleFit(bool value) async {
    if (value) {
      final granted =
          await ref.read(healthServiceProvider).requestPermissions();
      if (!granted) {
        if (mounted) {
          final s = S.of(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(s.wearablePermission),
            backgroundColor: AppTheme.warning,
          ));
        }
        return;
      }
    }
    setState(() => _googleFitEnabled = value);
    await _saveToSupabase(
      appleHealth: _appleHealthEnabled,
      googleFit: value,
    );
  }

  Future<void> _syncNow() async {
    final notifier = ref.read(healthSyncProvider.notifier);
    final success = await notifier.requestAndSync();
    if (mounted) {
      final s = S.of(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          success ? _syncSuccessText(s) : s.errorGenericBody,
        ),
        backgroundColor: success ? AppTheme.success : AppTheme.error,
      ));
    }
  }

  String _syncSuccessText(S s) => Platform.isIOS
      ? '${s.wearableAppleHealth} synced'
      : '${s.wearableGoogleFit} synced';

  String _lastSyncedLabel(DateTime? lastSynced) {
    if (lastSynced == null) return 'Not synced yet';
    final diff = DateTime.now().difference(lastSynced);
    if (diff.inMinutes < 1) return 'Last synced: just now';
    if (diff.inMinutes < 60) {
      return 'Last synced: ${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    }
    if (diff.inHours < 24) {
      return 'Last synced: ${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    }
    return 'Last synced: ${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);
    final syncState = ref.watch(healthSyncProvider);
    final lastSynced = syncState.asData?.value;
    final isSyncing = syncState.isLoading;
    final isConnected =
        Platform.isIOS ? _appleHealthEnabled : _googleFitEnabled;

    return Scaffold(
      appBar: AppBar(title: Text(s.settingsWearables)),
      body: ListView(
        children: [
          // ── Section header ────────────────────────────────────────────────
          _SectionHeader(label: 'Health Data Sources'),

          // ── Platform-specific toggle ──────────────────────────────────────
          if (Platform.isIOS)
            _HealthToggleTile(
              icon: Icons.favorite_outline,
              label: s.wearableAppleHealth,
              subtitle: 'Apple HealthKit',
              value: _appleHealthEnabled,
              isSaving: _isSaving,
              onChanged: _onToggleAppleHealth,
            )
          else if (Platform.isAndroid)
            _HealthToggleTile(
              icon: Icons.monitor_heart_outlined,
              label: s.wearableGoogleFit,
              subtitle: 'Google Fit / Health Connect',
              value: _googleFitEnabled,
              isSaving: _isSaving,
              onChanged: _onToggleGoogleFit,
            ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── Sync status ───────────────────────────────────────────────────
          _SectionHeader(label: 'Sync Status'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.md,
              vertical: AppTheme.sm,
            ),
            child: Row(
              children: [
                Icon(
                  isConnected
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  color: isConnected ? AppTheme.success : AppTheme.textHint,
                  size: 18,
                ),
                const SizedBox(width: AppTheme.sm),
                Expanded(
                  child: Text(
                    isConnected
                        ? _lastSyncedLabel(lastSynced)
                        : 'Not connected',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isConnected
                              ? AppTheme.textSecondary
                              : AppTheme.textHint,
                        ),
                  ),
                ),
              ],
            ),
          ),

          // ── Sync Now button ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.md,
              vertical: AppTheme.xs,
            ),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: (isSyncing || !isConnected) ? null : _syncNow,
                icon: isSyncing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.primary,
                        ),
                      )
                    : const Icon(Icons.sync, size: 18),
                label: Text(isSyncing ? 'Syncing…' : 'Sync Now'),
              ),
            ),
          ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── Data description ──────────────────────────────────────────────
          _SectionHeader(label: 'What We Read'),
          const _DataPointRow(
            icon: Icons.bedtime_outlined,
            label: 'Sleep Duration',
            description: 'Sleep start / end times and stages',
          ),
          const _DataPointRow(
            icon: Icons.favorite_outline,
            label: 'Heart Rate',
            description: 'Overnight resting heart rate',
          ),
          const _DataPointRow(
            icon: Icons.directions_walk_outlined,
            label: 'Steps',
            description: 'Daily step count for activity context',
          ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── Privacy note ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppTheme.md),
            child: Text(
              'Health data is used only to personalize your sleep program. '
              'We never share your data with third parties. '
              'You can disconnect at any time.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textHint,
                  ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: AppTheme.xxl),
        ],
      ),
    );
  }
}

// ─── Widgets ──────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppTheme.md, AppTheme.md, AppTheme.md, AppTheme.xs),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.textHint,
              letterSpacing: 1.0,
            ),
      ),
    );
  }
}

class _HealthToggleTile extends StatelessWidget {
  const _HealthToggleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.isSaving,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final bool isSaving;
  final Future<void> Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppTheme.primary),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: AppTheme.textHint),
      ),
      value: value,
      activeThumbColor: AppTheme.primary,
      onChanged: isSaving ? null : onChanged,
    );
  }
}

class _DataPointRow extends StatelessWidget {
  const _DataPointRow({
    required this.icon,
    required this.label,
    required this.description,
  });

  final IconData icon;
  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary, size: 20),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(
        description,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: AppTheme.textHint),
      ),
      dense: true,
    );
  }
}
