// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_show_db_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbProviderHash() => r'0eaaced8dcb2d1e651a6b400f7357d4f52919e6c';

/// See also [dbProvider].
@ProviderFor(dbProvider)
final dbProviderProvider = AutoDisposeProvider<DbFirestoreProvider>.internal(
  dbProvider,
  name: r'dbProviderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dbProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DbProviderRef = AutoDisposeProviderRef<DbFirestoreProvider>;
String _$userdbHash() => r'aafdb7976d3209bba8a23ccfd953243c897dbeca';

/// See also [Userdb].
@ProviderFor(Userdb)
final userdbProvider =
    AutoDisposeStreamNotifierProvider<Userdb, MyUser?>.internal(
  Userdb.new,
  name: r'userdbProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userdbHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Userdb = AutoDisposeStreamNotifier<MyUser?>;
String _$peopledbHash() => r'76b14e9ce74baf3a78c4f493257cbc894d69fa69';

/// See also [Peopledb].
@ProviderFor(Peopledb)
final peopledbProvider =
    AutoDisposeStreamNotifierProvider<Peopledb, List<Person>>.internal(
  Peopledb.new,
  name: r'peopledbProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$peopledbHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Peopledb = AutoDisposeStreamNotifier<List<Person>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
