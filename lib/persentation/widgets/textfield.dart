import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc.dart';
import 'package:weather_app_new/persentation/bloc/weather_bloc_event.dart';

class EnterCityTextField extends StatelessWidget {
  const EnterCityTextField({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextFormField(
          key: const Key("text-field"),
          textAlign: TextAlign.start,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                if (textEditingController.text.trim().isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  context.read<WeatherBloc>().add(
                        WeatherFetched(
                          cityName: textEditingController.text.trim(),
                        ),
                      );
                  textEditingController.clear();
                }
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            hintText: "Enter your city",
            hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
            fillColor: Colors.purple.shade700.withOpacity(0.3),
            filled: true,
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          controller: textEditingController,
          onFieldSubmitted: (value) async {
            if (textEditingController.text.trim().isNotEmpty) {
              context.read<WeatherBloc>().add(
                    WeatherFetched(
                      cityName: textEditingController.text.trim(),
                    ),
                  );
              textEditingController.clear();
            }
          }),
    );
  }
}
