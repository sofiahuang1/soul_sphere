import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_sphere/data/model/user_model.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryImpl(this.firestore);

  @override
  Future<UserEntity> getUserById(String userId) async {
    try {
      final doc = await firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Failed to fetch user data");
    }
  }

  @override
  Future<void> followUser(String currentUserId, String userId) async {
    try {
      final currentUserRef = firestore.collection('users').doc(currentUserId);
      final followedUserRef = firestore.collection('users').doc(userId);

      final batch = firestore.batch();

      batch.update(currentUserRef, {
        'followingCount': FieldValue.increment(1),
      });

      batch.update(followedUserRef, {
        'followerCount': FieldValue.increment(1),
      });

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to follow user: $e');
    }
  }
}
