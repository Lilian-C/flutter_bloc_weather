import 'package:flutter/material.dart';
import 'blocs/base/bloc.dart';
import 'package:flutter_weather_app/src/pages/login/login.page.dart';
import 'package:flutter_weather_app/src/values/theme.dart' as appTheme;
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast App',
      theme: appTheme.theme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => BlocProvider.of<AuthBloc>(context),
        child: LoginPage(),
      ),
    );
  }
}
