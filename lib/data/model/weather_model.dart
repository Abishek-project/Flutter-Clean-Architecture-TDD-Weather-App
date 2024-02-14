import 'package:weather_app_new/domain/entity/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required String countryName,
    required String cityName,
    required String main,
    required String iconCode,
    required double temperature,
    required int pressure,
    required String description,
  }) : super(
            countryName: countryName,
            cityName: cityName,
            main: main,
            iconCode: iconCode,
            temperature: temperature,
            pressure: pressure,
            description: description);

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['name'],
        main: json['weather'][0]['main'],
        iconCode: json['weather'][0]['icon'],
        temperature: json['main']['temp'],
        pressure: json['main']['pressure'],
        countryName: json["sys"]['country'],
        description: json["weather"][0]["description"],
      );

  WeatherEntity toEntity() => WeatherEntity(
      cityName: cityName,
      main: main,
      iconCode: iconCode,
      temperature: temperature,
      pressure: pressure,
      countryName: countryName,
      description: description);
}
