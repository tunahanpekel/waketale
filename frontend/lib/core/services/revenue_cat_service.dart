// lib/core/services/revenue_cat_service.dart
// RevenueCat integration for Waketale v2.
// Dart-define keys: REVENUECAT_APPLE_KEY / REVENUECAT_GOOGLE_KEY
// GitHub Secret:    PROD_RC_KEY_ANDROID

import 'dart:io';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../config/app_config.dart';

// ─── Service ──────────────────────────────────────────────────────────────────

class RevenueCatService {
  RevenueCatService._();

  static Future<void> initialize() async {
    try {
      final apiKey = Platform.isIOS
          ? AppConfig.revenueCatAppleKey
          : AppConfig.revenueCatGoogleKey;

      if (_isRcKeyPlaceholder(apiKey)) {
        debugPrint('[RevenueCat] skipped — no API key configured');
        return;
      }

      await Purchases.setLogLevel(
        AppConfig.isDev ? LogLevel.debug : LogLevel.error,
      );

      final config = PurchasesConfiguration(apiKey);
      await Purchases.configure(config);
    } catch (e) {
      debugPrint('[RevenueCat] initialize error: $e');
    }
  }

  static Future<void> identifyUser(String userId) async {
    try {
      await Purchases.logIn(userId);
    } catch (e) {
      debugPrint('[RevenueCat] identifyUser error: $e');
    }
  }

  static Future<bool> checkPremiumStatus() async {
    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey(AppConfig.entitlementId);
    } catch (_) {
      return false;
    }
  }

  static Future<void> logout() async {
    try {
      await Purchases.logOut();
    } catch (e) {
      debugPrint('[RevenueCat] logout error: $e');
    }
  }

  /// Purchase premium subscription. [annual] selects annual vs monthly plan.
  /// Returns true if the entitlement became active.
  static Future<bool> purchasePremium({required bool annual}) async {
    // Dev bypass — no real RC key configured
    final apiKey = Platform.isIOS
        ? AppConfig.revenueCatAppleKey
        : AppConfig.revenueCatGoogleKey;
    if (_isRcKeyPlaceholder(apiKey)) {
      debugPrint('[RevenueCat] dev bypass — purchasePremium returning true');
      return true;
    }
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      if (current == null) return false;

      final pkg = annual
          ? current.annual
          : current.monthly;
      if (pkg == null) return false;

      final result = await Purchases.purchase(PurchaseParams.package(pkg));
      return result.customerInfo.entitlements.active.containsKey(AppConfig.entitlementId);
    } catch (e) {
      debugPrint('[RevenueCat] purchasePremium error: $e');
      return false;
    }
  }

  /// Restore previous purchases. Returns true if entitlement restored.
  static Future<bool> restorePurchases() async {
    try {
      final info = await Purchases.restorePurchases();
      return info.entitlements.active.containsKey(AppConfig.entitlementId);
    } catch (e) {
      debugPrint('[RevenueCat] restorePurchases error: $e');
      return false;
    }
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

bool _isRcKeyPlaceholder(String key) =>
    key.isEmpty || key.startsWith('goog_YOUR') || key.startsWith('appl_YOUR');

final subscriptionProvider = FutureProvider<bool>((ref) async {
  // If no real RC key configured (dev/test), treat as premium
  final apiKey = Platform.isIOS
      ? AppConfig.revenueCatAppleKey
      : AppConfig.revenueCatGoogleKey;
  if (_isRcKeyPlaceholder(apiKey)) return true;

  try {
    final info = await Purchases.getCustomerInfo();
    return info.entitlements.active.containsKey(AppConfig.entitlementId);
  } catch (_) {
    return false;
  }
});

final isPremiumProvider = Provider<bool>((ref) {
  return ref.watch(subscriptionProvider).asData?.value ?? false;
});

/// Fetches the current RevenueCat offering.
/// Returns null if no offering is configured or RC is not initialised.
final offeringsProvider = FutureProvider<Offering?>((ref) async {
  final apiKey = Platform.isIOS
      ? AppConfig.revenueCatAppleKey
      : AppConfig.revenueCatGoogleKey;
  if (_isRcKeyPlaceholder(apiKey)) return null;

  try {
    final offerings = await Purchases.getOfferings();
    return offerings.current;
  } catch (e) {
    debugPrint('[RevenueCat] offeringsProvider error: $e');
    return null;
  }
});
