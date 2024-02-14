import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_new/domain/entity/weather_entity.dart';
import 'package:weather_app_new/domain/repository/weather_repository.dart';
import 'package:weather_app_new/domain/usecases/weather_usecases.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetWeatherUsecase getWeatherUsecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeatherUsecase = GetWeatherUsecase(mockWeatherRepository);
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
  test('Should get weather data from the WeatherRepository', () async {
    // arrange
    when(
      () => mockWeatherRepository.fetchWeatherData(testCityName),
    ).thenAnswer((_) async {
      return testWeatherEntity;
    });

    // act
    final result = await getWeatherUsecase.excute(testCityName);

    // assert
    expect(result, isA<WeatherEntity>());
  });
}
