import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.email});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'] as String,
      email: doc['email'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
    };
  }
}
