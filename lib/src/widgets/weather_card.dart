import 'package:flutter/material.dart';
import 'package:flutter_weather_app/src/values/colors.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final DateTime date;
  final String imageUrl;
  final String description;
  final String temperature;

  const WeatherCard({Key? key, required this.date, required this.imageUrl, required this.description, required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormatter = DateFormat('dd MMMM - hh:mm');
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              secondaryColor,
              accentColor,
              accentColorLight,
            ],
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, width: 95, height: 95, fit: BoxFit.cover),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  temperature,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    description,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  dateFormatter.format(date),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
