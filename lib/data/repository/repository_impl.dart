import 'dart:io';

import 'package:weather_app_new/core/error/error.dart';
import 'package:weather_app_new/data/data_sources/weather_data_source.dart';
import 'package:weather_app_new/domain/entity/weather_entity.dart';
import 'package:weather_app_new/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource weatherDataSource;

  WeatherRepositoryImpl({required this.weatherDataSource});

  @override
  Future<WeatherEntity> fetchWeatherData(String cityName) async {
    try {
      final response = await weatherDataSource.getCurrentWeather(cityName);
      print(response);
      return response.toEntity();
    } on SocketException {
      // Handle SocketException (e.g., no internet connection)
      throw const ConnectionFailure('Failed to connect to the network');
    } on HttpException {
      // Handle HttpException (e.g., server not reachable)
      throw const ServerFailure('An error has occurred');
    }
  }
}
