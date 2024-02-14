import '../entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> fetchWeatherData(String cityName);
}
