import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_new/constants/api_urls.dart';

class WeatherDataWidget extends StatelessWidget {
  const WeatherDataWidget({
    super.key,
    required this.city,
    required this.iconCode,
    required this.temperature,
    required this.main,
    required this.description,
  });

  final String city;
  final String iconCode;
  final double temperature;
  final String main;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.place,
                size: 15,
                color: Colors.white,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                city,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "Good morning !",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Center(
            child: Column(
              key: const Key("Weather_widget"),
              children: [
                Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    Urls.weatherIcon(
                      iconCode,
                    ),
                  ),
                  width: 150,
                  height: 150,
                ),
                Text(
                  '${temperature.round()}°C',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  main.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('EEEE dd yyyy').format(DateTime.now()),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
