import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call(String email, String password) async {
    final existingUser = await repository.getUserByEmail(email);
    if (existingUser != null) {
      throw Exception("User already exists with this email.");
    }
    return await repository.signUp(email, password);
  }
}
