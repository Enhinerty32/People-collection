import 'package:people_colletion_riverpod/config/models/person_model.dart';
import 'package:people_colletion_riverpod/config/models/user_model.dart';
import 'package:people_colletion_riverpod/provider/0-provider.dart';
import 'package:people_colletion_riverpod/provider/db_firestore_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_show_db_provider.g.dart';

@riverpod
DbFirestoreProvider dbProvider(Ref ref) => DbFirestoreProvider();

@riverpod
class Userdb extends _$Userdb {
  @override
  Stream<MyUser?> build() => ref.watch(dbProviderProvider).userStream();
}

@riverpod
class Peopledb extends _$Peopledb {
  @override
  Stream<List<Person>> build() => ref.watch(dbProviderProvider).getPeople();

  Future<void> removePerson(String personId) async {
    ref.watch(dbProviderProvider).removePerson(personId);
  }
 
}
