import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_sphere/data/datasource/local_data_source/local_datasource.dart';
import 'package:soul_sphere/data/datasource/remote_data_source/firebase_auth_datasource.dart';
import 'package:soul_sphere/data/repository_impl/auth_repository_impl.dart';
import 'package:soul_sphere/data/repository_impl/post_repository_impl.dart';
import 'package:soul_sphere/data/repository_impl/user_repository_impl.dart';
import 'package:soul_sphere/domain/repository/auth_repository.dart';
import 'package:soul_sphere/domain/repository/post_repository.dart';
import 'package:soul_sphere/domain/repository/user_repository.dart';
import 'package:soul_sphere/domain/usecase/get_user_profile_usecase.dart.dart';
import 'package:soul_sphere/domain/usecase/login_usecase.dart';
import 'package:soul_sphere/domain/usecase/sign_up_usecase.dart';
import 'package:soul_sphere/presentation/feature/home/user_bloc/user_bloc.dart';
import 'package:soul_sphere/presentation/feature/log_in/bloc/login_bloc.dart';
import 'package:soul_sphere/presentation/feature/one_one_chat/bloc/random_user_bloc.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_bloc.dart';
import 'package:soul_sphere/presentation/feature/profile/bloc/profile_bloc.dart';
import 'package:soul_sphere/presentation/feature/sign_up/bloc/signup_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Register Firebase Instances
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  // Register Firebase Data Source
  getIt.registerLazySingleton(() => FirebaseAuthDataSource(
        getIt<FirebaseAuth>(),
        getIt<FirebaseFirestore>(),
      ));

  // Register Repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<FirebaseAuthDataSource>()));

  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(getIt<FirebaseFirestore>()));

  // Register UseCases
  getIt.registerLazySingleton(
      () => GetUserProfileUseCase(getIt<UserRepository>()));

  // Register Blocs
  getIt.registerFactory(
    () => ProfileBloc(getUserProfileUseCase: getIt<GetUserProfileUseCase>()),
  );

  getIt.registerFactory(
      () => SignupBloc(signUpUseCase: SignUpUseCase(getIt<AuthRepository>())));

  getIt.registerFactory(
      () => LoginBloc(loginUseCase: LoginUseCase(getIt<AuthRepository>())));

  getIt.registerFactory(() => UserBloc(getIt<AuthRepository>()));

  getIt.registerFactory<RandomUserBloc>(
    () => RandomUserBloc(
      authRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerFactory<PostBloc>(() => PostBloc(getIt<PostRepository>()));

  // Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Register Local Data Source
  getIt.registerFactory<LocalDataSource>(() => LocalDataSource());
}
