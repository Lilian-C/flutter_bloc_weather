import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/src/blocs/base/bloc.dart';
import 'package:flutter_weather_app/src/helpers/storage/storage.helper.dart';
import 'package:flutter_weather_app/src/helpers/storage/storage.keys.dart';
import 'package:flutter_weather_app/src/widgets/centered_loading.dart';
import '../../blocs/forecast/forecast_cubit.dart';
import '../../blocs/forecast/forecast_state.dart';
import 'package:flutter_weather_app/src/helpers/utils.dart';
import 'package:flutter_weather_app/src/models/forecast.model.dart';
import 'package:flutter_weather_app/src/models/report.model.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/base/endpoints.dart' as endpoints;
import 'package:flutter_weather_app/src/widgets/weather_card.dart';

class ForecastSearchPage extends StatefulWidget {
  const ForecastSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _ForecastSearchPageState createState() => _ForecastSearchPageState();
}

class _ForecastSearchPageState extends State<ForecastSearchPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ForecastCubit>(context).onGetForecast("Paris");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String?>(
          future: StorageHelper.get(StorageKeys.username),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.hasError) {
              return const Text('Bienvenue');
            } else if (snapshot.hasData) {
              return Text('Bienvenue ' + (snapshot.data ?? ""));
            } else {
              return const Text('...');
            }
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<ForecastCubit, ForecastState>(
          listener: (context, state) {
            if (state is ForecastError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ForecastCubit, ForecastState>(
            builder: (context, state) {
              if (state is ForecastInitial) {
                return const Center(child: CityInputField());
              } else if (state is ForecastLoading) {
                return const CenteredLoading();
              } else if (state is ForecastLoaded) {
                return ForecastReport(report: state.report);
              } else if (state is ForecastError) {
                return const Center(child: CityInputField());
              }
              return const CenteredLoading();
            },
          ),
        ),
      ),
    );
  }
}

class ForecastReport extends StatelessWidget {
  final ReportModel report;

  const ForecastReport({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String city = report.city?.name ?? "Unknown";

    return ListView(
      shrinkWrap: true,
      children: [
        const CityInputField(),
        const SizedBox(height: 20),
        const Text("Prévisions météo pour:", textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Text(city, style: const TextStyle(fontSize: 25), textAlign: TextAlign.center),
        const SizedBox(height: 20),
        ListView.separated(
            shrinkWrap: true,
            itemCount: report.list?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildWeatherCard(report.list!.elementAt(index)),
            separatorBuilder: (context, index) => const SizedBox(height: 15)),
      ],
    );
  }

  Widget _buildWeatherCard(ForecastModel forecast) {
    // We could also create an extension fromSecondsSinceEpoch for the DateTime object
    DateTime date = DateTime.fromMillisecondsSinceEpoch((forecast.dt ?? 0) * 1000);

    String imageUrl = endpoints.forecast.weatherImage + (forecast.weather?[0].icon ?? "") + ".png";
    String description = (forecast.weather?[0].main ?? "") + ": " + (forecast.weather?[0].description ?? "");
    String temperature = forecast.main?.temp != null ? kelvinToCelsius(forecast.main!.temp!).toStringAsFixed(1) + "°" : "";

    return Align(
      alignment: Alignment.topCenter,
      child: WeatherCard(
        date: date,
        imageUrl: imageUrl,
        description: description,
        temperature: temperature,
      ),
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Chercher une ville",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final forecastBloc = BlocProvider.of<ForecastCubit>(context);
    forecastBloc.onGetForecast(cityName);
  }
}
