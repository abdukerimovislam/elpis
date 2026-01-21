// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$realCurrentWeekHash() => r'e858a906323009add85ae004712d6d928bc90fc4';

/// See also [realCurrentWeek].
@ProviderFor(realCurrentWeek)
final realCurrentWeekProvider = AutoDisposeStreamProvider<int>.internal(
  realCurrentWeek,
  name: r'realCurrentWeekProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$realCurrentWeekHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RealCurrentWeekRef = AutoDisposeStreamProviderRef<int>;
String _$selectedWeekHash() => r'873ba65f5abfab9778febc27b23734b07ab0c8d6';

/// See also [SelectedWeek].
@ProviderFor(SelectedWeek)
final selectedWeekProvider =
    AutoDisposeNotifierProvider<SelectedWeek, int>.internal(
  SelectedWeek.new,
  name: r'selectedWeekProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedWeekHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedWeek = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
