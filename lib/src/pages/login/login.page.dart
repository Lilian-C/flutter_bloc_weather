import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/src/blocs/auth/auth_event.dart';
import 'package:flutter_weather_app/src/blocs/base/bloc.dart';
import 'package:flutter_weather_app/src/values/colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import 'package:flutter_weather_app/src/helpers/utils.dart';
import 'package:flutter_weather_app/src/pages/forecast/forecast.search.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            } else if (state is AuthLoaded) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ForecastBloc>(context),
                    child: const ForecastSearchPage(),
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthInitial) {
                return buildInitialInput();
              } else if (state is AuthLoading) {
                return buildLoading();
              } else if (state is AuthError) {
                return buildInitialInput();
              }
              return buildLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: LoginForm(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _loginController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            TextFormField(
              controller: _loginController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Email',
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty || !isEmail(value)) {
                  return "Merci de renseigner un email valide";
                }
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Mot de passe',
                labelText: 'Mot de passe',
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Merci de renseigner un mot de passe valide";
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Valider'),
              style: TextButton.styleFrom(
                primary: accentColor,
                backgroundColor: lightGrey,
              ),
              onPressed: () {
                if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                  final authBloc = BlocProvider.of<AuthBloc>(context);
                  authBloc.add(GetAuth(_loginController.text, _passwordController.text));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
