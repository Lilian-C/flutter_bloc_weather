// We could pick up a different URL based on a prod/preprod configuration
const String authURL = "https://myloginapi.com"; // Fake URL since we don't have a real one
const String apiURL = "https://api.openweathermap.org";

class _Auth {
  final login = authURL + "/api/login";
}

class _Forecast {
  final fiveDayForecasts = apiURL + "/data/2.5/forecast";
  final weatherImage = apiURL + "/img/w/";
}

final forecast = _Forecast();
final auth = _Auth();
