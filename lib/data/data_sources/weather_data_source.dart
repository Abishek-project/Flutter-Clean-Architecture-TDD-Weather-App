import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_new/data/model/weather_model.dart';
import '../../constants/api_urls.dart';

abstract class WeatherDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherDataSourceImpl extends WeatherDataSource {
  final http.Client client;
  WeatherDataSourceImpl(this.client);
  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await client.get(
      Uri.parse(
        Urls.currentWeatherByName(cityName),
      ),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw http.ClientException('Failed to get weather data');
    }
  }
}
