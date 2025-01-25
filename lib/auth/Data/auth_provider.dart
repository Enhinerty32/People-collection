import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screen/login_screen.dart';
import '../services/error_auth_provider.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection("users");
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Registrar Usuario
  Future<User?> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Implemeta los valores primarios vacios que no den match con Firestore 
      await _createItem(userCredential.user!.uid, {
        "id": userCredential.user!.uid,
        "email": userCredential.user!.email,
        "name": name,
        "phone": phone,
        "listPeople": [],
      });
      await signOut();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ErrorAuthProvider().registerWithEmailAndPasswordErrors(
        error: e.message, context: context);
      return null;
    }
  }

  // Crear un documento con un ID específico
  Future<void> _createItem(String id, Map<String, dynamic> data) async {
    try {
      await _firestore.doc(id).set(data);
    } catch (e) {
      // Manejo de errores opcional
    }
  }

  // Iniciar Sesión
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ErrorAuthProvider().signInWithEmailAndPasswordErrors(
        error: e.message, context: context);
      return null;
    }
  }


  // Autenticacion por Google
  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    }
    return null;
  }

  // Autenticacion por Phone
  void signInWithPhone({required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        // Manejo de errores
      },
      codeSent: (verificationId, resendToken) {},
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // Cambiar Correo Electrónico
  Future<void> changeEmail(String newEmail) async {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario != null) {
      try {
        await usuario.verifyBeforeUpdateEmail(newEmail);
        print('Se envió un correo de verificación al nuevo correo.');
      } on FirebaseAuthException catch (e) {
        print('Error: ${e.message}');
      }
    } else {
      print('No hay usuario autenticado.');
    }
  }

  // Eliminar el usuario
  Future<void> deleteUser({
    required String email,
    required String password,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await _firestore.doc(user.uid).delete();
        await user.delete();
        print('Usuario eliminado exitosamente');
      } else {
        print('No hay usuario autenticado');
      }
    } catch (e) {
      print('Error al eliminar la cuenta: $e');
    }
    Get.offNamed("/login");
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
    
      await _auth.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      // Manejo de errores
    }
  }

  // Recuperar contraseña
  Future<String?> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "Correo de reactivación enviado";
    } on FirebaseAuthException catch (e) {
      return "Error: ${e.message}";
    }
  }

  // Obtener el token
  Future<String> getToken() async {
    try {
          final userToken = await  _auth.currentUser?.getIdToken();
    return  userToken ??''  ;
    } catch (e) {
      return '';
    }
 
  }

  // Verificar la expiración del token
  Future<void> checkTokenExpiration() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final idTokenResult = await user.getIdTokenResult();
        final expirationTime = idTokenResult.expirationTime!;
        final currentTime = DateTime.now();
        final timeRemaining = expirationTime.difference(currentTime);

        if (timeRemaining.isNegative) {
          print("El token ha expirado.");
        } else {
          print("El token expirará en ${timeRemaining.inMinutes} minutos.");
        }
      } else {
        print("No hay usuario autenticado.");
      }
    } catch (e) {
      print("Error al verificar el token: $e");
    }
  }
}
