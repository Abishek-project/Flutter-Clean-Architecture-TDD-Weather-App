import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_new/constants/api_urls.dart';
import 'package:weather_app_new/data/data_sources/weather_data_source.dart';
import 'package:weather_app_new/data/model/weather_model.dart';

class MockHTTPClient extends Mock implements http.Client {}

void main() {
  late MockHTTPClient mockHttpClient;
  late WeatherDataSourceImpl weatherDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHTTPClient();
    weatherDataSourceImpl = WeatherDataSourceImpl(mockHttpClient);
  });
  group('get current weather api call -', () {
    var file = File("test/helpers/dummy_data/sample_json.json");
    var jsonString = file.readAsStringSync();
    const testCityName = 'New York';
    test(
        "should return weather model when the response status code equal to 200",
        () async {
      // Arrange
      when(
        () => mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer((_) async {
        return Response(jsonString, 200);
      });
      // Act
      final response =
          await weatherDataSourceImpl.getCurrentWeather(testCityName);

      // Assert
      expect(response, isA<WeatherModel>());
    });
    test("should throw a  exception when the response code is 404 or other",
        () async {
      // Arrange
      when(
        () => mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer((_) async {
        return Response("{}", 404);
      });
      // Act
      final res = weatherDataSourceImpl.getCurrentWeather(testCityName);

      // Assert
      expect(res, throwsException);
    });
  });
}
