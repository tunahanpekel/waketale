// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(checkInHistory)
final checkInHistoryProvider = CheckInHistoryFamily._();

final class CheckInHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SleepCheckIn>>,
          List<SleepCheckIn>,
          FutureOr<List<SleepCheckIn>>
        >
    with
        $FutureModifier<List<SleepCheckIn>>,
        $FutureProvider<List<SleepCheckIn>> {
  CheckInHistoryProvider._({
    required CheckInHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'checkInHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$checkInHistoryHash();

  @override
  String toString() {
    return r'checkInHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SleepCheckIn>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SleepCheckIn>> create(Ref ref) {
    final argument = this.argument as int;
    return checkInHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckInHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$checkInHistoryHash() => r'c9cbbe8d2495689d5f085d4019ac2fd53e6c7fe0';

final class CheckInHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SleepCheckIn>>, int> {
  CheckInHistoryFamily._()
    : super(
        retry: null,
        name: r'checkInHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CheckInHistoryProvider call(int days) =>
      CheckInHistoryProvider._(argument: days, from: this);

  @override
  String toString() => r'checkInHistoryProvider';
}
