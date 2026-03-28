// lib/core/services/health_service.dart
// Waketale v2 — Health package wrapper.
// Supports Apple HealthKit (iOS) and Google Health Connect (Android).
// Uses the `health` package ^12.2.0.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';

// ─── Data types requested ──────────────────────────────────────────────────────

const _kReadTypes = [
  HealthDataType.SLEEP_ASLEEP,
  HealthDataType.SLEEP_AWAKE,
  HealthDataType.HEART_RATE,
  HealthDataType.STEPS,
];

// ─── Sleep interval model ──────────────────────────────────────────────────────

class SleepInterval {
  const SleepInterval({
    required this.from,
    required this.to,
    required this.type,
  });

  final DateTime from;
  final DateTime to;
  final HealthDataType type;

  Duration get duration => to.difference(from);
}

// ─── Service ──────────────────────────────────────────────────────────────────

class HealthService {
  HealthService._() : _health = Health();

  static final HealthService instance = HealthService._();

  final Health _health;

  /// Returns true only on iOS or Android.
  bool isAvailable() => Platform.isIOS || Platform.isAndroid;

  /// Configures the health plugin and requests read permissions for sleep,
  /// heart rate and steps. Returns true when all permissions are granted.
  Future<bool> requestPermissions() async {
    if (!isAvailable()) return false;
    try {
      _health.configure();
      final permissions =
          _kReadTypes.map((_) => HealthDataAccess.READ).toList();
      final granted = await _health.requestAuthorization(
        _kReadTypes,
        permissions: permissions,
      );
      debugPrint('[HealthService] requestPermissions → $granted');
      return granted;
    } catch (e) {
      debugPrint('[HealthService] requestPermissions error: $e');
      return false;
    }
  }

  /// Returns whether we currently have read authorization.
  Future<bool> hasPermissions() async {
    if (!isAvailable()) return false;
    try {
      final result = await _health.hasPermissions(
        _kReadTypes,
        permissions: _kReadTypes.map((_) => HealthDataAccess.READ).toList(),
      );
      return result ?? false;
    } catch (e) {
      debugPrint('[HealthService] hasPermissions error: $e');
      return false;
    }
  }

  /// Fetches sleep data points (SLEEP_ASLEEP + SLEEP_AWAKE) between [from] and [to].
  Future<List<SleepInterval>> getSleepData(
      DateTime from, DateTime to) async {
    if (!isAvailable()) return [];
    try {
      final points = await _health.getHealthDataFromTypes(
        startTime: from,
        endTime: to,
        types: [HealthDataType.SLEEP_ASLEEP, HealthDataType.SLEEP_AWAKE],
      );
      return points
          .map((p) => SleepInterval(
                from: p.dateFrom,
                to: p.dateTo,
                type: p.type,
              ))
          .toList();
    } catch (e) {
      debugPrint('[HealthService] getSleepData error: $e');
      return [];
    }
  }

  /// Fetches total step count between [from] and [to].
  Future<int> getSteps(DateTime from, DateTime to) async {
    if (!isAvailable()) return 0;
    try {
      final steps = await _health.getTotalStepsInInterval(from, to);
      return steps ?? 0;
    } catch (e) {
      debugPrint('[HealthService] getSteps error: $e');
      return 0;
    }
  }

  /// Fetches heart rate data points between [from] and [to].
  Future<List<HealthDataPoint>> getHeartRate(
      DateTime from, DateTime to) async {
    if (!isAvailable()) return [];
    try {
      return await _health.getHealthDataFromTypes(
        startTime: from,
        endTime: to,
        types: [HealthDataType.HEART_RATE],
      );
    } catch (e) {
      debugPrint('[HealthService] getHeartRate error: $e');
      return [];
    }
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

/// Exposes the singleton HealthService.
final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService.instance;
});

/// Async provider: true when health permissions are already granted.
final healthPermissionsProvider = FutureProvider<bool>((ref) {
  return ref.read(healthServiceProvider).hasPermissions();
});

/// Notifier that tracks last-synced timestamp and manages the sync flow.
class HealthSyncNotifier extends AsyncNotifier<DateTime?> {
  @override
  Future<DateTime?> build() async => null;

  Future<bool> requestAndSync() async {
    state = const AsyncLoading();
    try {
      final service = ref.read(healthServiceProvider);
      final granted = await service.requestPermissions();
      if (!granted) {
        state = const AsyncData(null);
        return false;
      }
      // Fetch last 7 days of sleep
      final now = DateTime.now();
      final week = now.subtract(const Duration(days: 7));
      await service.getSleepData(week, now);
      final syncedAt = DateTime.now();
      state = AsyncData(syncedAt);
      return true;
    } catch (e, st) {
      state = AsyncError(e, st);
      return false;
    }
  }
}

final healthSyncProvider =
    AsyncNotifierProvider<HealthSyncNotifier, DateTime?>(
        HealthSyncNotifier.new);
