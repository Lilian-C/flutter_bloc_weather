import 'package:flutter/material.dart';
import 'blocs/base/bloc.dart';
import 'package:flutter_weather_app/src/pages/login/login.page.dart';
import 'package:flutter_weather_app/src/values/theme.dart' as app_theme;
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast App',
      theme: app_theme.theme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => BlocProvider.of<AuthBloc>(context),
        child: const LoginPage(),
      ),
    );
  }
}
