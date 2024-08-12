import 'package:soul_sphere/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getUserByEmail(String email);
  Future<UserEntity> signUp(String email, String password);
}
