// lib/features/settings/presentation/notifications_settings_screen.dart
// Waketale v2 — Notification preferences sub-screen.
//
// Three toggles:
//   1. Bedtime reminder   — 30 min before user's bedtime (default: on, 22:30)
//   2. Morning check-in   — at user's wake time (default: on, 07:00)
//   3. Weekly progress    — Sunday 09:00 AM (default: on)
//
// Preferences persisted in SharedPreferences (keys below).
// Scheduling delegated to NotificationService.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/l10n/app_strings.dart';

// ─── SharedPreferences keys ───────────────────────────────────────────────────

const _kBedtimeEnabled = 'notif_bedtime_enabled';
const _kCheckinEnabled = 'notif_checkin_enabled';
const _kWeeklyEnabled  = 'notif_weekly_enabled';
const _kBedtimeHour    = 'notif_bedtime_hour';
const _kBedtimeMinute  = 'notif_bedtime_minute';
const _kCheckinHour    = 'notif_checkin_hour';
const _kCheckinMinute  = 'notif_checkin_minute';

// ─── State ────────────────────────────────────────────────────────────────────

class _NotifPrefs {
  const _NotifPrefs({
    required this.bedtimeEnabled,
    required this.checkinEnabled,
    required this.weeklyEnabled,
    required this.bedtime,
    required this.wakeTime,
  });

  final bool bedtimeEnabled;
  final bool checkinEnabled;
  final bool weeklyEnabled;
  final TimeOfDay bedtime;
  final TimeOfDay wakeTime;

  _NotifPrefs copyWith({
    bool? bedtimeEnabled,
    bool? checkinEnabled,
    bool? weeklyEnabled,
    TimeOfDay? bedtime,
    TimeOfDay? wakeTime,
  }) =>
      _NotifPrefs(
        bedtimeEnabled: bedtimeEnabled ?? this.bedtimeEnabled,
        checkinEnabled: checkinEnabled ?? this.checkinEnabled,
        weeklyEnabled: weeklyEnabled ?? this.weeklyEnabled,
        bedtime: bedtime ?? this.bedtime,
        wakeTime: wakeTime ?? this.wakeTime,
      );
}

// ─── Provider ────────────────────────────────────────────────────────────────

class _NotifPrefsNotifier extends AsyncNotifier<_NotifPrefs> {
  @override
  Future<_NotifPrefs> build() async {
    final prefs = await SharedPreferences.getInstance();
    return _NotifPrefs(
      bedtimeEnabled: prefs.getBool(_kBedtimeEnabled) ?? true,
      checkinEnabled: prefs.getBool(_kCheckinEnabled) ?? true,
      weeklyEnabled:  prefs.getBool(_kWeeklyEnabled)  ?? true,
      bedtime: TimeOfDay(
        hour:   prefs.getInt(_kBedtimeHour)   ?? 22,
        minute: prefs.getInt(_kBedtimeMinute) ?? 30,
      ),
      wakeTime: TimeOfDay(
        hour:   prefs.getInt(_kCheckinHour)   ?? 7,
        minute: prefs.getInt(_kCheckinMinute) ?? 0,
      ),
    );
  }

  Future<void> setBedtimeEnabled(bool value, S s) async {
    final current = state.value;
    if (current == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kBedtimeEnabled, value);
    final next = current.copyWith(bedtimeEnabled: value);
    state = AsyncData(next);
    if (value) {
      await NotificationService.scheduleBedtimeReminder(next.bedtime, s);
    } else {
      await NotificationService.cancelBedtimeReminder();
    }
  }

  Future<void> setCheckinEnabled(bool value, S s) async {
    final current = state.value;
    if (current == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kCheckinEnabled, value);
    final next = current.copyWith(checkinEnabled: value);
    state = AsyncData(next);
    if (value) {
      await NotificationService.scheduleCheckinReminder(next.wakeTime, s);
    } else {
      await NotificationService.cancelCheckinReminder();
    }
  }

  Future<void> setWeeklyEnabled(bool value, S s) async {
    final current = state.value;
    if (current == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kWeeklyEnabled, value);
    state = AsyncData(current.copyWith(weeklyEnabled: value));
    if (value) {
      await NotificationService.scheduleWeeklyReport(s);
    } else {
      await NotificationService.cancelWeeklyReport();
    }
  }

  Future<void> updateBedtime(TimeOfDay time, S s) async {
    final current = state.value;
    if (current == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kBedtimeHour, time.hour);
    await prefs.setInt(_kBedtimeMinute, time.minute);
    final next = current.copyWith(bedtime: time);
    state = AsyncData(next);
    if (next.bedtimeEnabled) {
      await NotificationService.scheduleBedtimeReminder(time, s);
    }
  }

  Future<void> updateWakeTime(TimeOfDay time, S s) async {
    final current = state.value;
    if (current == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kCheckinHour, time.hour);
    await prefs.setInt(_kCheckinMinute, time.minute);
    final next = current.copyWith(wakeTime: time);
    state = AsyncData(next);
    if (next.checkinEnabled) {
      await NotificationService.scheduleCheckinReminder(time, s);
    }
  }
}

final _notifPrefsProvider =
    AsyncNotifierProvider<_NotifPrefsNotifier, _NotifPrefs>(
        _NotifPrefsNotifier.new);

// ─── Screen ───────────────────────────────────────────────────────────────────

class NotificationsSettingsScreen extends ConsumerWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);
    final s = S.of(context);
    final prefsAsync = ref.watch(_notifPrefsProvider);
    final notifier = ref.read(_notifPrefsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(s.settingsNotifications)),
      body: prefsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            s.errorGenericBody,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.error),
          ),
        ),
        data: (prefs) => ListView(
          children: [
            // ── Bedtime reminder ──────────────────────────────────────────────
            _SectionHeader(label: s.notifScreenBedtimeSection),
            SwitchListTile(
              secondary: const Icon(
                Icons.bedtime_outlined,
                color: AppTheme.primary,
              ),
              title: Text(
                s.notifScreenBedtimeToggle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                s.notifScreenBedtimeSubtitle,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppTheme.textSecondary),
              ),
              value: prefs.bedtimeEnabled,
              activeThumbColor: AppTheme.primary,
              onChanged: (v) => notifier.setBedtimeEnabled(v, s),
            ),
            if (prefs.bedtimeEnabled)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 72, vertical: 0),
                title: Text(
                  s.notifScreenBedtimeLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppTheme.textSecondary),
                ),
                trailing: _TimeChip(
                  time: prefs.bedtime,
                  onTap: () => _pickTime(
                    context,
                    initial: prefs.bedtime,
                    onPicked: (t) => notifier.updateBedtime(t, s),
                  ),
                ),
              ),

            const Divider(color: AppTheme.bgBorder, height: 1),

            // ── Morning check-in ──────────────────────────────────────────────
            _SectionHeader(label: s.notifScreenCheckinSection),
            SwitchListTile(
              secondary: const Icon(
                Icons.wb_sunny_outlined,
                color: AppTheme.accent,
              ),
              title: Text(
                s.notifScreenCheckinToggle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                s.notifScreenCheckinSubtitle,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppTheme.textSecondary),
              ),
              value: prefs.checkinEnabled,
              activeThumbColor: AppTheme.accent,
              onChanged: (v) => notifier.setCheckinEnabled(v, s),
            ),
            if (prefs.checkinEnabled)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 72, vertical: 0),
                title: Text(
                  s.notifScreenCheckinLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppTheme.textSecondary),
                ),
                trailing: _TimeChip(
                  time: prefs.wakeTime,
                  onTap: () => _pickTime(
                    context,
                    initial: prefs.wakeTime,
                    onPicked: (t) => notifier.updateWakeTime(t, s),
                  ),
                ),
              ),

            const Divider(color: AppTheme.bgBorder, height: 1),

            // ── Weekly report ─────────────────────────────────────────────────
            _SectionHeader(label: s.notifScreenWeeklySection),
            SwitchListTile(
              secondary: const Icon(
                Icons.bar_chart_outlined,
                color: AppTheme.accentTeal,
              ),
              title: Text(
                s.notifScreenWeeklyToggle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                s.notifScreenWeeklySubtitle,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppTheme.textSecondary),
              ),
              value: prefs.weeklyEnabled,
              activeThumbColor: AppTheme.accentTeal,
              onChanged: (v) => notifier.setWeeklyEnabled(v, s),
            ),

            const SizedBox(height: AppTheme.xxl),
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime(
    BuildContext context, {
    required TimeOfDay initial,
    required Future<void> Function(TimeOfDay) onPicked,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppTheme.primary,
            onPrimary: AppTheme.textPrimary,
            surface: AppTheme.bgSurface,
            onSurface: AppTheme.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      await onPicked(picked);
    }
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

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.time, required this.onTap});

  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(color: AppTheme.primary.withValues(alpha: 0.4)),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
