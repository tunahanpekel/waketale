// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cbtiWeek)
final cbtiWeekProvider = CbtiWeekProvider._();

final class CbtiWeekProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  CbtiWeekProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cbtiWeekProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cbtiWeekHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return cbtiWeek(ref);
  }
}

String _$cbtiWeekHash() => r'0fc3d42023f71c552f7a869ae719fd67da78317f';
