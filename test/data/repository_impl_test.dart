import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_new/core/error/error.dart';
import 'package:weather_app_new/data/data_sources/weather_data_source.dart';
import 'package:weather_app_new/data/model/weather_model.dart';
import 'package:weather_app_new/data/repository/repository_impl.dart';
import 'package:weather_app_new/domain/entity/weather_entity.dart';

class MockWeatherDataSource extends Mock implements WeatherDataSource {}

void main() {
  late MockWeatherDataSource mockWeatherDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;
  setUp(() {
    mockWeatherDataSource = MockWeatherDataSource();
    weatherRepositoryImpl =
        WeatherRepositoryImpl(weatherDataSource: mockWeatherDataSource);
  });
  WeatherModel testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 302,
    pressure: 1009,
    countryName: 'India',
    description: "overcast clouds",
  );

  group("get current weather", () {
    const testCityName = 'New York';
    test("should return weather model when calling a datasource", () async {
      when(
        () => mockWeatherDataSource.getCurrentWeather(testCityName),
      ).thenAnswer((_) async {
        return testWeatherModel;
      });
      final result = await weatherRepositoryImpl.fetchWeatherData(testCityName);
      expect(result, isA<WeatherEntity>());
    });
    test("should throw a ConnectionFailure for socket exception", () async {
      // Arrange
      when(() => mockWeatherDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));

      // Act & Assert
      expect(
        () async => await weatherRepositoryImpl.fetchWeatherData(testCityName),
        throwsA(
          isA<ConnectionFailure>().having(
            (e) => e.message,
            'message',
            'Failed to connect to the network',
          ),
        ),
      );
    });
    test("should throw a ConnectionFailure for server exception", () async {
      // Arrange
      when(() => mockWeatherDataSource.getCurrentWeather(testCityName))
          .thenThrow(const HttpException('An error has occurred'));

      // Act & Assert
      expect(
        () async => await weatherRepositoryImpl.fetchWeatherData(testCityName),
        throwsA(
          isA<ServerFailure>().having(
            (e) => e.message,
            'message',
            'An error has occurred',
          ),
        ),
      );
    });
  });
}
