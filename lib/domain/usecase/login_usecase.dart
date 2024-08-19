import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String email, String password) async {
    final existingUser = await repository.getUserByEmail(email);
    if (existingUser == null) {
      throw Exception("No user found with this email.");
    }
    return existingUser;
  }
}
