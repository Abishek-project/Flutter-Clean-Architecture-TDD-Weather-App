import '../entity/weather_entity.dart';
import '../repository/weather_repository.dart';

class GetWeatherUsecase {
  final WeatherRepository weatherRepository;
  GetWeatherUsecase(this.weatherRepository);

  Future<WeatherEntity> excute(String cityName) async {
    return weatherRepository.fetchWeatherData(cityName);
  }
}
