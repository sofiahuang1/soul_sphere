import 'package:equatable/equatable.dart';
import 'package:soul_sphere/app/constants/app_assets.dart';
import 'package:soul_sphere/app/constants/app_constants.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String avatar;
  final String bio;
  final DateTime createdAt;
  final int followersCount;
  final int followingCount;
  final int postCount;

  const UserEntity({
    required this.id,
    required this.email,
    this.avatar = AppAssets.defaultAvatar,
    this.bio = AppConstants.defaultBio,
    required this.createdAt,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postCount = 0,
  });

  @override
  List<Object> get props => [
        id,
        email,
        avatar,
        bio,
        createdAt,
        followersCount,
        followingCount,
        postCount,
      ];
}
