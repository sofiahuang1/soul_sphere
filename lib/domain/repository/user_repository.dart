import 'package:soul_sphere/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUserById(String userId);
  Future<void> followUser(String currentUserId, String userId);
}
