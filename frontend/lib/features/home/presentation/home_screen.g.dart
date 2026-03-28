// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

final class CurrentUserProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserProfile?>,
          UserProfile?,
          FutureOr<UserProfile?>
        >
    with $FutureModifier<UserProfile?>, $FutureProvider<UserProfile?> {
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<UserProfile?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserProfile?> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'18eaa606aa5256c93f63971cfed3fa85c83d9422';

@ProviderFor(todayCheckIn)
final todayCheckInProvider = TodayCheckInProvider._();

final class TodayCheckInProvider
    extends
        $FunctionalProvider<
          AsyncValue<SleepCheckIn?>,
          SleepCheckIn?,
          FutureOr<SleepCheckIn?>
        >
    with $FutureModifier<SleepCheckIn?>, $FutureProvider<SleepCheckIn?> {
  TodayCheckInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayCheckInProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayCheckInHash();

  @$internal
  @override
  $FutureProviderElement<SleepCheckIn?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SleepCheckIn?> create(Ref ref) {
    return todayCheckIn(ref);
  }
}

String _$todayCheckInHash() => r'61cebc49a0f846514161559e5dbd23c07a209591';

@ProviderFor(todayActionPlan)
final todayActionPlanProvider = TodayActionPlanProvider._();

final class TodayActionPlanProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActionPlan?>,
          ActionPlan?,
          FutureOr<ActionPlan?>
        >
    with $FutureModifier<ActionPlan?>, $FutureProvider<ActionPlan?> {
  TodayActionPlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayActionPlanProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayActionPlanHash();

  @$internal
  @override
  $FutureProviderElement<ActionPlan?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActionPlan?> create(Ref ref) {
    return todayActionPlan(ref);
  }
}

String _$todayActionPlanHash() => r'cf699afe7544390a7860327931c577a9f93782b4';
