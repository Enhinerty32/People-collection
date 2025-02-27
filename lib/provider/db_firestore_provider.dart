import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:people_colletion_riverpod/config/models/person_model.dart';
import 'package:people_colletion_riverpod/config/models/user_model.dart';

class DbFirestoreProvider {
  static const String usersCollection = "users";
  static const String peopleCollection = "people";

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  DbFirestoreProvider({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  User? get _currentUser => _auth.currentUser;

  Stream<MyUser?> userStream() {
    final userId = _currentUser?.uid;
    if (userId == null) {
      return Stream.value(null);
    }

    return _firestore.collection(usersCollection).doc(userId).snapshots().map(
          (snapshot) =>
              snapshot.exists ? MyUser.fromJson(snapshot.data()!) : null,
        );
  }

Stream<List<Person>> getPeople() {
  return userStream().asyncMap((user) async {
    if (user == null || user.people.isEmpty) return [];

    // Obtener los documentos de Firestore para cada ID
    final people = await Future.wait(user.people.map((id) async {
      try {
        final doc = await _firestore.collection(peopleCollection).doc(id).get();
        return doc.exists ? Person.fromJson(doc.data()!) : null;
      } catch (e) {
        return null; // Si hay un error, ignoramos ese usuario
      }
    }));

    return 
    people.whereType<Person>().toList(); // Filtrar nulos y devolver la lista
  }); 
}

Future<void> removePerson(String personId) async {
  final userId = _currentUser?.uid;
  if (userId == null) return;

  final userRef = _firestore.collection(usersCollection).doc(userId);
  final peopleRef = _firestore.collection('people').doc(personId);

  await userRef.update({
    'people': FieldValue.arrayRemove([personId]) // Elimina el ID de la lista del usuario
  });

  // Verificar si aún hay referencias al ID en otros usuarios antes de borrar
  final usersWithPerson = await _firestore
      .collection(usersCollection)
      .where('people', arrayContains: personId)
      .get();

  if (usersWithPerson.docs.isEmpty) {
    await peopleRef.delete(); // Eliminar solo si ya no lo usa nadie más
  }
}

Future<void> addPerson(Person newPerson) async {
  final userId = _currentUser?.uid;
  if (userId == null) throw Exception('Usuario no autenticado');

  final batch = _firestore.batch();
  final personRef = _firestore.collection(peopleCollection).doc(); // Genera un nuevo ID
  final userRef = _firestore.collection(usersCollection).doc(userId);

  // Crear una copia del objeto con el ID asignado
  final personWithId = newPerson.copyWith(id: personRef.id); 

  batch.set(personRef, personWithId.toJson()); // Guardar con ID incluido
  batch.update(userRef, {
    'people': FieldValue.arrayUnion([personRef.id])
  });

  await batch.commit();
}
Future<void> updatePerson(Person updatedPerson) async {
  final userId = _currentUser?.uid;
  if (userId == null) throw Exception('Usuario no autenticado');

  final batch = _firestore.batch();
  final personRef = _firestore.collection(peopleCollection).doc(updatedPerson.id); // Usar el ID existente
  final userRef = _firestore.collection(usersCollection).doc(userId);

  // Actualizar la persona en la colección de personas
  batch.update(personRef, updatedPerson.toJson());

  // Si es necesario, también puedes actualizar la referencia en la colección de usuarios
  // Por ejemplo, si el ID de la persona cambió (aunque no es común)
  // batch.update(userRef, {
  //   'people': FieldValue.arrayRemove([oldPersonId]), // Si el ID cambió, elimina el antiguo
  //   'people': FieldValue.arrayUnion([updatedPerson.id]) // Agrega el nuevo ID
  // });

  await batch.commit();
}
  Future<void> updateUser(MyUser data) async {
    final userId = _currentUser?.uid;
    if (userId == null) return;

    await _firestore
        .collection(usersCollection)
        .doc(userId)
        .set(data.toJson(), SetOptions(merge: true));
  }
}
