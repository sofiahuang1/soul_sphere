import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/data/datasource/remote_data_source/firebase_auth_datasource.dart';
import 'package:soul_sphere/data/repository_impl/auth_repository_impl.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';
import 'package:soul_sphere/domain/usecase/login_usecase.dart';
import 'package:soul_sphere/domain/usecase/sign_up_usecase.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_bloc.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_bloc.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton(() => FirebaseAuthDataSource(
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
      ));

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<FirebaseAuthDataSource>()));

  getIt.registerFactory(
      () => SignupBloc(signUpUseCase: SignUpUseCase(getIt<AuthRepository>())));

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: LoginUseCase(getIt<AuthRepository>())),
  );

  getIt.registerFactory<UserBloc>(
    () => UserBloc(getIt<AuthRepository>()),
  );
}
