import 'package:bloc/bloc.dart';
import 'package:weather_app_new/domain/usecases/weather_usecases.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_event.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUsecase getWeatherUsecase;
  WeatherBloc(this.getWeatherUsecase) : super(WeatherInitialState()) {
    on<WeatherFetched>(_fetchWeatherData);
  }

  void _fetchWeatherData(
      WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final result = await getWeatherUsecase.excute(event.cityName);

      emit(
        WeatherSuccess(weatherEntity: result),
      );
    } catch (e) {
      emit(
        WeatherFailure(
          e.toString(),
        ),
      );
    }
  }
}
