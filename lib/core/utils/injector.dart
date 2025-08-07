import 'package:event_app/core/helper/dio_helper.dart';
import 'package:event_app/core/helper/storage_service.dart.dart';
import 'package:event_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:event_app/features/auth/domain/repository/auth_repository.dart';
import 'package:event_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void initInjector() async {
  locator.registerSingleton<DioHelper>(
    DioHelper(baseUrl: String.fromEnvironment('BASE_URL_PROD')),
  );

  // initialize storage service
  locator.registerSingleton<StorageService>(StorageService());

  //REPOSITORY
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  //USECASE
  locator.registerLazySingleton<RegisterAccountUseCase>(
    () => RegisterAccountUseCase(locator()),
  );
  locator.registerLazySingleton<LoginAccountUseCase>(
    () => LoginAccountUseCase(locator()),
  );
}
