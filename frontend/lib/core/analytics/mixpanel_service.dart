// lib/core/analytics/mixpanel_service.dart
// Mixpanel analytics for Waketale v2.
// Initialize in main() before runApp().

import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import '../config/app_config.dart';

class MixpanelService {
  MixpanelService._();

  static Mixpanel? _instance;

  static Future<void> init() async {
    if (AppConfig.mixpanelToken.isEmpty ||
        AppConfig.mixpanelToken.startsWith('YOUR')) {
      return;
    }
    _instance = await Mixpanel.init(
      AppConfig.mixpanelToken,
      optOutTrackingDefault: false,
      trackAutomaticEvents: false,
    );
  }

  static void track(String event, {Map<String, dynamic>? properties}) {
    _instance?.track(event, properties: properties);
  }

  static void identify(String userId) {
    _instance?.identify(userId);
  }

  static void setPeople(Map<String, dynamic> properties) {
    for (final entry in properties.entries) {
      _instance?.getPeople().set(entry.key, entry.value);
    }
  }

  static void reset() {
    _instance?.reset();
  }
}

// ── Waketale v2 Event Names ────────────────────────────────────────────────────

class WaketaleEvents {
  WaketaleEvents._();

  // Onboarding
  static const String onboardingStarted    = 'onboarding_started';
  static const String onboardingCompleted  = 'onboarding_completed';
  static const String onboardingSkipped    = 'onboarding_skipped';
  static const String signInCompleted      = 'sign_in_completed';

  // Check-in
  static const String checkInStarted      = 'check_in_started';
  static const String checkInCompleted    = 'check_in_completed';
  static const String checkInSkipped      = 'check_in_skipped';

  // Sleep Score
  static const String sleepScoreViewed    = 'sleep_score_viewed';
  static const String scoreDetailExpanded = 'score_detail_expanded';

  // Action Plan
  static const String actionPlanViewed    = 'action_plan_viewed';
  static const String actionStepChecked   = 'action_step_checked';
  static const String actionWhyTapped     = 'action_why_tapped';

  // Coach
  static const String coachMessageSent    = 'coach_message_sent';
  static const String coachResponseReceived = 'coach_response_received';
  static const String cbtiStageViewed     = 'cbti_stage_viewed';

  // Progress
  static const String progressTabViewed   = 'progress_tab_viewed';
  static const String chartPeriodChanged  = 'chart_period_changed';
  static const String milestoneAchieved   = 'milestone_achieved';
  static const String streakUpdated       = 'streak_updated';

  // Routines
  static const String routineStarted      = 'routine_started';
  static const String routineCompleted    = 'routine_completed';
  static const String routineEdited       = 'routine_edited';
  static const String reminderSet         = 'reminder_set';

  // Sleep Tracker (passive)
  static const String sleepTrackingStarted  = 'sleep_tracking_started';
  static const String sleepTrackingStopped  = 'sleep_tracking_stopped';
  static const String smartAlarmFired       = 'smart_alarm_fired';

  // Wearables
  static const String wearableConnected     = 'wearable_connected';
  static const String wearableDisconnected  = 'wearable_disconnected';
  static const String healthDataImported    = 'health_data_imported';

  // Social
  static const String buddyInviteSent       = 'buddy_invite_sent';
  static const String weeklyRecapShared     = 'weekly_recap_shared';

  // Monetization
  static const String paywallViewed         = 'paywall_viewed';
  static const String trialStarted          = 'trial_started';
  static const String subscriptionPurchased = 'subscription_purchased';
  static const String subscriptionRestored  = 'subscription_restored';
  static const String subscriptionCancelled = 'subscription_cancelled';

  // Settings
  static const String languageChanged       = 'language_changed';
  static const String notificationToggled   = 'notification_toggled';
  static const String accountDeleted        = 'account_deleted';
}
