import 'package:get_it/get_it.dart';
import 'package:weather_app_new/data/data_sources/weather_data_source.dart';
import 'package:weather_app_new/data/repository/repository_impl.dart';
import 'package:weather_app_new/domain/repository/weather_repository.dart';
import 'package:weather_app_new/domain/usecases/weather_usecases.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

setupLocator() {
  // usecase
  locator.registerLazySingleton<GetWeatherUsecase>(
    () => GetWeatherUsecase(
      locator(),
    ),
  );
  // datasource
  locator.registerLazySingleton<WeatherDataSource>(
    () => WeatherDataSourceImpl(
      locator(),
    ),
  );
  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherDataSource: locator(),
    ),
  );

  // bloc
  locator.registerFactory<WeatherBloc>(
    () => WeatherBloc(
      locator(),
    ),
  );
  // external
  locator.registerLazySingleton(() => http.Client());
}
