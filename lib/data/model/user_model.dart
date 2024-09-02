import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.avatar = AppAssets.defaultAvatar,
    super.bio = AppConstants.defaultBio,
    required super.createdAt,
    super.followersCount = 0,
    super.followingCount = 0,
    super.postCount = 0,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: data['id'] as String,
      email: data['email'] as String,
      avatar: data['avatar'] as String? ?? AppAssets.defaultAvatar,
      bio: data['bio'] as String? ?? AppConstants.defaultBio,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      followersCount: data['followersCount'] as int? ?? 0,
      followingCount: data['followingCount'] as int? ?? 0,
      postCount: data['postCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'createdAt': Timestamp.fromDate(createdAt),
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postCount': postCount,
    };
  }
}
