import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_event.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_state.dart';
import 'package:weather_app_new/persentation/widgets/textfield.dart';
import 'package:weather_app_new/persentation/widgets/weather_data.dart';
import '../bloc/weather_bloc.dart';

class WeatherScreenBody extends StatelessWidget {
  const WeatherScreenBody({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 20, 30),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.pink.shade500,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.pink.shade500,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 600,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitialState) {
                  context.read<WeatherBloc>().add(
                        WeatherFetched(
                          cityName: 'KanyaKumari',
                        ),
                      );
                }
                if (state is WeatherLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                    ),
                  );
                }
                if (state is WeatherFailure) {
                  return const Center(
                    child: Text(
                      "Something Went Wrong!",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
                if (state is WeatherSuccess) {
                  final data = state.weatherEntity;
                  final city = data.cityName;
                  final iconCode = data.iconCode;
                  final temperature = data.temperature;
                  final main = data.main;
                  final description = data.description;
                  return WeatherDataWidget(
                      city: city,
                      iconCode: iconCode,
                      temperature: temperature,
                      main: main,
                      description: description);
                }
                return Container();
              },
            ),
            EnterCityTextField(textEditingController: textEditingController),
          ],
        ),
      ),
    );
  }
}
