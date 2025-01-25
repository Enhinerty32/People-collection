import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Base interface for models that can convert from/to JSON.
abstract class BaseModel {
  Map<String, dynamic> toJson();
  BaseModel fromJson(Map<String, dynamic> json);
}

/// Generic StorageProvider for any model that implements BaseModel.
class StorageProvider<T extends BaseModel> extends GetxController {
  final Rx<T?> model = Rx<T?>(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collectionPath;

  /// Accepts the path to the Firestore collection and a factory function for the model.
  final T Function(Map<String, dynamic> json) modelFactory;

  StorageProvider({required this.collectionPath, required this.modelFactory});

  @override
  void onInit() {
    super.onInit();
    listenToModel();
  }

  /// Listen to changes for the current user's document.
  void listenToModel() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    _firestore.collection(collectionPath).doc(userId).snapshots().listen((doc) {
      if (doc.exists && doc.data() != null) {
        model.value = modelFactory(doc.data()!);
      } else {
        model.value = null;
      }
    }, onError: (error) {
      print("Error listening to $collectionPath: $error");
    });
  }

  /// Update the user's document with new data.
  Future<void> updateModel(T data) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      await _firestore
          .collection(collectionPath)
          .doc(userId)
          .set(data.toJson(), SetOptions(merge: true));
    } catch (e) {
      print("Error updating model in $collectionPath: $e");
    }
  }
}
