// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$countryCodeHash() => r'9dd4e6d8170a7f1e1226b9aac13ca3de2c7ee0f1';

/// See also [CountryCode].
@ProviderFor(CountryCode)
final countryCodeProvider =
    AutoDisposeNotifierProvider<CountryCode, String>.internal(
  CountryCode.new,
  name: r'countryCodeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countryCodeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CountryCode = AutoDisposeNotifier<String>;
String _$editPersonHash() => r'45344b2b5a8a07121621c7ef6498b0538ddd220d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EditPerson extends BuildlessAutoDisposeNotifier<Person> {
  late final Person person;

  Person build(
    Person person,
  );
}

/// See also [EditPerson].
@ProviderFor(EditPerson)
const editPersonProvider = EditPersonFamily();

/// See also [EditPerson].
class EditPersonFamily extends Family<Person> {
  /// See also [EditPerson].
  const EditPersonFamily();

  /// See also [EditPerson].
  EditPersonProvider call(
    Person person,
  ) {
    return EditPersonProvider(
      person,
    );
  }

  @override
  EditPersonProvider getProviderOverride(
    covariant EditPersonProvider provider,
  ) {
    return call(
      provider.person,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editPersonProvider';
}

/// See also [EditPerson].
class EditPersonProvider
    extends AutoDisposeNotifierProviderImpl<EditPerson, Person> {
  /// See also [EditPerson].
  EditPersonProvider(
    Person person,
  ) : this._internal(
          () => EditPerson()..person = person,
          from: editPersonProvider,
          name: r'editPersonProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editPersonHash,
          dependencies: EditPersonFamily._dependencies,
          allTransitiveDependencies:
              EditPersonFamily._allTransitiveDependencies,
          person: person,
        );

  EditPersonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.person,
  }) : super.internal();

  final Person person;

  @override
  Person runNotifierBuild(
    covariant EditPerson notifier,
  ) {
    return notifier.build(
      person,
    );
  }

  @override
  Override overrideWith(EditPerson Function() create) {
    return ProviderOverride(
      origin: this,
      override: EditPersonProvider._internal(
        () => create()..person = person,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        person: person,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<EditPerson, Person> createElement() {
    return _EditPersonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditPersonProvider && other.person == person;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, person.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditPersonRef on AutoDisposeNotifierProviderRef<Person> {
  /// The parameter `person` of this provider.
  Person get person;
}

class _EditPersonProviderElement
    extends AutoDisposeNotifierProviderElement<EditPerson, Person>
    with EditPersonRef {
  _EditPersonProviderElement(super.provider);

  @override
  Person get person => (origin as EditPersonProvider).person;
}

String _$selectSexHash() => r'c5681cbe6dfdfc9943b41d11e666ccf770688538';

/// See also [SelectSex].
@ProviderFor(SelectSex)
final selectSexProvider = NotifierProvider<SelectSex, SexType>.internal(
  SelectSex.new,
  name: r'selectSexProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectSexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectSex = Notifier<SexType>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
