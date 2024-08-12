import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:soul_sphere/app/utils/encryption_password.dart';
import 'package:soul_sphere/data/model/user_model.dart';

class FirebaseAuthDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseAuthDataSource(this.firebaseAuth, this.firestore);

  Future<UserModel?> getUserByEmail(String email) async {
    final querySnapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return UserModel.fromFirestore(querySnapshot.docs.first);
    } else {
      return null;
    }
  }

  Future<UserModel> signUp(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user?.uid;
    if (uid == null) {
      throw Exception('Cannot find uid for this user');
    }

    final hashedPassword = EncryptionPassword.hashPassword(password);

    final userModel =
        UserModel(id: uid, email: email, password: hashedPassword);

    await firestore.collection('users').doc(uid).set(userModel.toMap());

    return userModel;
  }
}
