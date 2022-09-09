import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_weather_app/src/blocs/base/bloc.dart';
import 'package:flutter_weather_app/src/helpers/connection.helper.dart';
import 'package:flutter_weather_app/src/pages/forecast/forecast.search.dart';
import 'package:flutter_weather_app/src/pages/login/login.page.dart';
import 'package:flutter_weather_app/src/repositories/auth.repository.dart';
import 'package:flutter_weather_app/src/repositories/forecast.repository.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/auth.service.dart';
import 'package:flutter_weather_app/src/repositories/sources/network/forecast.service.dart';
import 'src/app.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              AuthRepository(
                AuthService(),
                ConnectionHelper(),
              ),
            ),
            child: LoginPage(),
          ),
          BlocProvider(
            create: (context) => ForecastBloc(
              ForecastRepository(
                ForecastService(),
                ConnectionHelper(),
              ),
            ),
            child: ForecastSearchPage(),
          ),
        ],
        child: MyApp(),
      ),
    );
