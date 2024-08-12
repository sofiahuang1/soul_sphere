import 'package:soul_sphere/data/datasource/remote_data_source/firebase_auth_datasource.dart';
import 'package:soul_sphere/domain/entities/user_entity.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
    return await dataSource.getUserByEmail(email);
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    return await dataSource.signUp(email, password);
  }
}
