import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_new/data/model/weather_model.dart';
import 'package:weather_app_new/domain/entity/weather_entity.dart';

void main() {
  WeatherModel testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 302,
    pressure: 1009,
    countryName: 'India',
    description: "overcast clouds",
  );
  group("Weather model test -", () {
    test("should a sub class of weather entity", () {
      expect(testWeatherModel, isA<WeatherEntity>());
    });

    test("should return a valid model from a json", () {
      var file = File("test/helpers/dummy_data/sample_json.json");
      var jsonString = file.readAsStringSync();
      // Parse JSON string to Map
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      final result = WeatherModel.fromJson(jsonData);
      expect(result, isA<WeatherModel>());
    });
  });
}
