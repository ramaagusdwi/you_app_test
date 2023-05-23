import 'package:flutter_you_app/core/errors/error_handler.dart';
import 'package:flutter_you_app/core/network/api.dart';
import 'package:flutter_you_app/data/di/auth_dependency.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

abstract class IconfigureDependencies {
  inject();

  injectDataSource();

  injectRepository();

  injectBloc();

  injectUseCase();
}

Future configureDependencies() async {
  //! External
  sl.registerLazySingleton(() => Api.createDio());
  sl.registerLazySingleton(() => ErrorHandler());

  //! features dependencies
  InjectDependencyAuth().inject();
}
