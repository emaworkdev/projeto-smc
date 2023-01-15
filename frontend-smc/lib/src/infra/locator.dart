import 'package:smc/src/services/service.dart';
import 'package:smc/src/view_model/view_model.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LoginService());
  locator.registerFactory(() => LoginViewModel());
  locator.registerLazySingleton(() => UserService());
  locator.registerFactory(() => UserViewModel());
  locator.registerLazySingleton(() => SettingService());
  locator.registerFactory(() => SettingViewModel());
  locator.registerLazySingleton(() => ConectionService());
  locator.registerFactory(() => ConectionViewModel());
  locator.registerLazySingleton(() => QuestionService());
  locator.registerFactory(() => QuestionViewModel());
  locator.registerLazySingleton(() => ShotsService());
  locator.registerFactory(() => ShotsViewModel());
}
