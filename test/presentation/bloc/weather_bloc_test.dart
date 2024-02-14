import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_new/domain/entity/weather_entity.dart';
import 'package:weather_app_new/domain/usecases/weather_usecases.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_event.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_state.dart';

class MockGetWeatherUseCase extends Mock implements GetWeatherUsecase {}

void main() {
  late MockGetWeatherUseCase mockGetWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetWeatherUseCase = MockGetWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetWeatherUseCase);
  });

  WeatherEntity testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 302,
    pressure: 1009,
    countryName: 'India',
    description: "overcast clouds",
  );
  const testCityName = 'New York';
  group("bloc test -", () {
    test(
      'initial state should be empty',
      () {
        expect(
          weatherBloc.state,
          equals(
            WeatherInitialState(),
          ),
        );
      },
    );
    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetWeatherUseCase.excute(testCityName))
            .thenAnswer((_) async => testWeatherEntity);
        return weatherBloc;
      },
      act: (bloc) {
        bloc.add(WeatherFetched(cityName: testCityName));
      },
      expect: () =>
          [WeatherLoading(), WeatherSuccess(weatherEntity: testWeatherEntity)],
    );
    blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherFailure] when an error occurs',
      build: () {
        when(() => mockGetWeatherUseCase.excute(testCityName))
            .thenThrow('Error fetching weather data');
        return weatherBloc;
      },
      act: (bloc) {
        bloc.add(WeatherFetched(cityName: testCityName));
      },
      expect: () =>
          [WeatherLoading(), WeatherFailure('Error fetching weather data')],
    );
  });
}
