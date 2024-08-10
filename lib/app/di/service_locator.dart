import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/data/repository_impl/authentication_repository_impl.dart';
import 'package:soul_sphere/domain/repository/authentication_repository.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_bloc.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(firebaseAuth: getIt<FirebaseAuth>()),
  );

  getIt.registerFactory<SignUpBloc>(
    () =>
        SignUpBloc(authenticationRepository: getIt<AuthenticationRepository>()),
  );

  getIt.registerFactory<LoginBloc>(
    () =>
        LoginBloc(authenticationRepository: getIt<AuthenticationRepository>()),
  );
}
