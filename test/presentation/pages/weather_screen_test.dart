import 'dart:io';

import 'package:bloc_test/bloc_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_new/domain/entity/weather_entity.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_event.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_state.dart';
import 'package:weather_app_new/persentation/pages/weather_screen.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();

    HttpOverrides.global = null;
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

  Widget _makeTestWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "text field should trigger state to change from initial to loading ",
    (WidgetTester widgetTester) async {
      // Set the initial state when the mockWeatherBloc is created
      when(() => mockWeatherBloc.state).thenReturn(WeatherInitialState());
      await widgetTester.pumpWidget(_makeTestWidget(WeatherScreen()));

      // Find the TextFormField by its key
      final textFormField = find.byType(TextFormField);

      // Expect to find exactly one TextFormField
      expect(textFormField, findsOneWidget);

      await widgetTester.enterText(textFormField, "London");
      await widgetTester.pump();
      expect(find.text("London"), findsOneWidget);
      await widgetTester.pump();
      await widgetTester.testTextInput.receiveAction(TextInputAction.done);
      // Verify that the bloc received the WeatherFetched event with the correct city name
      verify(() => mockWeatherBloc.add(WeatherFetched(cityName: "London")));
    },
  );
  testWidgets(
    "show loader when state in loading",
    (WidgetTester widgetTester) async {
      // Set the initial state when the mockWeatherBloc is created
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());
      await widgetTester.pumpWidget(_makeTestWidget(WeatherScreen()));

      // Expect to find exactly one TextFormField
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
  testWidgets(
    "show weather data when state in success",
    (WidgetTester widgetTester) async {
      // Set the initial state when the mockWeatherBloc is created
      when(() => mockWeatherBloc.state)
          .thenReturn(WeatherSuccess(weatherEntity: testWeatherEntity));
      await widgetTester.pumpWidget(_makeTestWidget(WeatherScreen()));
      await widgetTester.pumpAndSettle();
      // Expect to find exactly one TextFormField
      expect(find.byKey(const Key("Weather_widget")), findsOneWidget);
    },
  );
  testWidgets(
    "intially call the weather fetch fucnction when state in wheatherInitial",
    (WidgetTester widgetTester) async {
      // Set the initial state when the mockWeatherBloc is created
      when(() => mockWeatherBloc.state).thenReturn(WeatherInitialState());
      await widgetTester.pumpWidget(_makeTestWidget(WeatherScreen()));
      // Verify that the bloc received the WeatherFetched event with the correct city name
      verify(() => mockWeatherBloc.add(WeatherFetched(cityName: "London")));
    },
  );
}
