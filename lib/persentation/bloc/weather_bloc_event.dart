import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherFetched extends WeatherEvent {
  final String cityName;

  WeatherFetched({required this.cityName});
}
