// lib/features/settings/presentation/settings_screen.dart
// Waketale v2 — Settings: profile, language, notifications, subscription,
// wearables, privacy (GDPR delete account), sign out.
// GDPR: delete account calls Edge Function 'delete-account' (required per QA checklist).

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/l10n/app_strings.dart';
import '../../../core/network/supabase_client.dart';
import '../../../core/services/revenue_cat_service.dart';
import '../../../core/theme/app_theme.dart';
import 'notifications_settings_screen.dart';
import 'wearables_settings_screen.dart';

// ─── Screen ───────────────────────────────────────────────────────────────────

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isSigningOut = false;
  bool _isDeletingAccount = false;

  String get _currentLang =>
      Localizations.localeOf(context).languageCode.toUpperCase();

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);
    try {
      await Supabase.instance.client.auth.signOut();
      // GoRouter auth guard will redirect to onboarding
    } catch (e) {
      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.errorGenericBody),
          backgroundColor: AppTheme.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSigningOut = false);
    }
  }

  Future<void> _confirmDeleteAccount() async {
    final s = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.bgSurface,
        title: Text(s.settingsDeleteAccount),
        content: Text(s.settingsDeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(s.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              s.settingsDeleteAccount,
              style: const TextStyle(color: AppTheme.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await _deleteAccount();
  }

  Future<void> _deleteAccount() async {
    setState(() => _isDeletingAccount = true);
    try {
      // GDPR-compliant delete: Edge Function wipes all user data
      await SupabaseClientService.client.functions.invoke(
        SupabaseClientService.fnDeleteAccount,
      );
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      if (mounted) {
        final s = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(s.errorGenericBody),
          backgroundColor: AppTheme.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _isDeletingAccount = false);
    }
  }

  void _showLanguagePicker() {
    final s = S.of(context);
    final notifier = ref.read(localeProvider.notifier);
    final langs = {
      'en': 'English',
      'tr': 'Türkçe',
      'es': 'Español',
      'de': 'Deutsch',
      'fr': 'Français',
      'pt': 'Português',
    };
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusLg)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.md),
            child: Text(s.settingsLanguage,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          ...langs.entries.map((e) => ListTile(
                title: Text(e.value),
                trailing: e.key == Localizations.localeOf(context).languageCode
                    ? const Icon(Icons.check, color: AppTheme.primary)
                    : null,
                onTap: () {
                  notifier.setLocale(e.key);
                  Navigator.of(ctx).pop();
                },
              )),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final s = S.of(context);
    final isPremium = ref.watch(isPremiumProvider);
    final user = Supabase.instance.client.auth.currentUser;
    final version = '2.0.0';

    return Scaffold(
      appBar: AppBar(title: Text(s.settingsTitle)),
      body: ListView(
        children: [
          // ── Profile section ─────────────────────────────────────────────────
          _SectionHeader(label: s.settingsProfile),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.primary.withValues(alpha: 0.2),
              child: Text(
                (user?.email ?? 'U').substring(0, 1).toUpperCase(),
                style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w700),
              ),
            ),
            title: Text(
              user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              isPremium ? '⭐ Premium' : 'Free',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isPremium ? AppTheme.accent : AppTheme.textSecondary,
                  ),
            ),
          ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── App section ─────────────────────────────────────────────────────
          _SectionHeader(label: s.settingsSectionApp),
          _SettingsTile(
            icon: Icons.language,
            label: s.settingsLanguage,
            value: _currentLang,
            onTap: _showLanguagePicker,
          ),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            label: s.settingsNotifications,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const NotificationsSettingsScreen(),
              ),
            ),
          ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── Premium section ─────────────────────────────────────────────────
          _SectionHeader(label: s.settingsSectionPremium),
          if (!isPremium)
            _SettingsTile(
              icon: Icons.star_outline,
              label: s.settingsSubscription,
              onTap: () => context.push('/paywall'),
              iconColor: AppTheme.accent,
            )
          else
            _SettingsTile(
              icon: Icons.star,
              label: s.settingsSubscription,
              value: 'Premium',
              onTap: () {},
              iconColor: AppTheme.accent,
            ),

          _SettingsTile(
            icon: Icons.watch_outlined,
            label: s.settingsWearables,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const WearablesSettingsScreen(),
              ),
            ),
          ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── Privacy section ─────────────────────────────────────────────────
          _SectionHeader(label: s.settingsPrivacy),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            label: s.settingsPrivacy,
            onTap: () {
              // TODO: privacy policy webview
            },
          ),
          _SettingsTile(
            icon: Icons.help_outline,
            label: s.settingsSupport,
            onTap: () {
              // TODO: support / feedback
            },
          ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── Account section ─────────────────────────────────────────────────
          _SectionHeader(label: s.settingsSectionAccount),
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.textSecondary),
            title: Text(s.settingsSignOut,
                style: Theme.of(context).textTheme.bodyMedium),
            trailing: _isSigningOut
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.textSecondary,
                    ),
                  )
                : null,
            onTap: _isSigningOut ? null : _signOut,
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: AppTheme.error),
            title: Text(s.settingsDeleteAccount,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppTheme.error)),
            trailing: _isDeletingAccount
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.error,
                    ),
                  )
                : null,
            onTap: _isDeletingAccount ? null : _confirmDeleteAccount,
          ),

          const Divider(color: AppTheme.bgBorder, height: 1),

          // ── Version ─────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppTheme.md),
            child: Text(
              '${s.settingsVersion} $version',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
      padding: const EdgeInsets.fromLTRB(AppTheme.md, AppTheme.md, AppTheme.md, AppTheme.xs),
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

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? value;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppTheme.textSecondary),
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value!,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: AppTheme.textHint, size: 18),
        ],
      ),
      onTap: onTap,
    );
  }
}
