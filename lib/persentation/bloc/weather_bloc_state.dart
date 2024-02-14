import 'package:equatable/equatable.dart';
import 'package:weather_app_new/domain/entity/weather_entity.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WeatherInitialState extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherEntity weatherEntity;

  WeatherSuccess({required this.weatherEntity});
}

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure(this.error);
}
