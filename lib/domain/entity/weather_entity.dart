class WeatherEntity {
  final String countryName;
  final String cityName;
  final String main;
  final String iconCode;
  final String description;
  final double temperature;
  final int pressure;
  WeatherEntity(
      {required this.countryName,
      required this.cityName,
      required this.main,
      required this.iconCode,
      required this.temperature,
      required this.pressure,
      required this.description});
}
