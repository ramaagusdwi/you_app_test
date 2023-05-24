import 'package:flutter_you_app/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_you_app/data/repositories/auth_repository_impl.dart';
import 'package:flutter_you_app/domain/repositories/auth_repository.dart';
import 'package:flutter_you_app/domain/usecase/login.dart';
import 'package:flutter_you_app/domain/usecase/register.dart';
import 'package:flutter_you_app/injection_container.dart';
import 'package:flutter_you_app/presentation/bloc/login_bloc.dart';
import 'package:flutter_you_app/presentation/bloc/register_bloc.dart';

class InjectDependencyAuth extends IconfigureDependencies {
  @override
  inject() {
    injectBloc();
    injectDataSource();
    injectRepository();
    injectUseCase();
  }

  @override
  injectBloc() {
    sl.registerFactory(() => LoginBloc(sl()));
    sl.registerFactory(() => RegisterBloc(sl()));
    // sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
  }

  @override
  injectDataSource() {
    sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
          sl(),
        ));
  }

  @override
  injectRepository() {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
  }

  @override
  injectUseCase() {
    sl.registerLazySingleton(() => Login(sl()));
    sl.registerLazySingleton(() => Register(sl()));
  }
}
