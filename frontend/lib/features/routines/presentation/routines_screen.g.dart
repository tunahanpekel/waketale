// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routines_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userRoutines)
final userRoutinesProvider = UserRoutinesProvider._();

final class UserRoutinesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>?>,
          Map<String, dynamic>?,
          FutureOr<Map<String, dynamic>?>
        >
    with
        $FutureModifier<Map<String, dynamic>?>,
        $FutureProvider<Map<String, dynamic>?> {
  UserRoutinesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRoutinesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRoutinesHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>?> create(Ref ref) {
    return userRoutines(ref);
  }
}

String _$userRoutinesHash() => r'b8b2e68c05fa13d617300191b26fae0b560edc21';
