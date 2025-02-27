import 'package:people_colletion_riverpod/auth/providers/error_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class AuthFirebaseProvider {
  final FirebaseAuth auth = FirebaseAuth.instance; 
  final   firestore = FirebaseFirestore.instance.collection("users");


// Registrar Usuario
  Future<User?> registerWithEmailAndPassword(
      {
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Crear un documento en Firestore con el ID del usuario y agregar datos adicionales 
      await createItem(userCredential.user!.uid, {
        "id": userCredential.user!.uid,
        "email": userCredential.user!.email,
        "people": [],
      });

      print('se creo credencial');
      return userCredential.user;

      
    } on FirebaseAuthException catch (e) {
      ErrorAuthProvider().registerWithEmailAndPasswordErrors(
          error: "Error created Register: ${e.message}", context: context);
    ErrorAuthProvider().anyError(
          error: "${e.message}", context: context);

      print('No se creo credencial');
      return null;
    }
  }


  
  // Crear un documento con un ID específico
  Future<void> createItem(String id, Map<String, dynamic> data) async {
    try {
      DocumentReference docRef =
         firestore.doc(id);

      // Guardar el documento en Firestore con el ID proporcionado
      await docRef.set(data);
      // print("Documento creado con ID: $id");
    } catch (e) {
      // print("Error al crear el documento: $e");
    }
  }



// Cerrar sesion
  Future<void> signOut( ) async {
    try {
      await auth.signOut();
      
    } catch (e) {
      print(e);
    } 
  }


// Iniciar Sesión
  Future<User?> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      try {
        // final String? tokenId = await userCredential.user?.getIdToken(true);
      } catch (e) {
        // print('Error en login :Mact Tokenid y RxTokenID');
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ErrorAuthProvider()
          .signInWithEmailAndPasswordErrors(error: e.message, context: context);
      // print("Error: ${e.message}");
      return null;
    }
  }


// Recuperar contrasena
  Future<String?> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return "Active ";
    } on FirebaseAuthException catch (e) {
      // print("Error: ${e.message}");
      return "Error: ${e.message}";
    }
  }


// Eliminar el usuario
Future<void> deleteUser({required String email, required String password}) async {
  try {
    // Obtén el usuario actualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Crea las credenciales para reautenticar al usuario
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,  // Debes pedirle al usuario que ingrese su contraseña
      );

      // Reautentica al usuario con las credenciales proporcionadas
      await user.reauthenticateWithCredential(credential);
      print('Iniciando la eliminación');

      // Eliminar el documento del usuario de Firestore
      await firestore.doc(user.uid).delete();
      print('Eliminación en Firestore exitosa');

      // Eliminar la cuenta de Firebase Authentication
      await user.delete();
      print('Eliminación en Authentication exitosa');
      // Redirigir al usuario a la página de login
      
       
       
      print('Usuario eliminado exitosamente');
    } else {
      print('No hay usuario autenticado');
    }
  } catch (e) {
    print('Error en eliminar la cuenta: ${e.toString()}');
  }

}


}

