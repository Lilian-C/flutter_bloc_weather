class ForecastModel {
  int? dt;
  String? dt_txt;
  Main? main;
  List<Weather>? weather;
  Wind? wind;
  int? visibility;

  ForecastModel({
    this.dt,
    this.main,
    this.weather,
    this.wind,
    this.visibility,
  });

  static List<ForecastModel> fromJsonList(List<dynamic> json) =>
      json.map((i) => ForecastModel.fromJson(i)).toList();

  ForecastModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    visibility = json['visibility'];
    dt_txt = json['dt_txt'];
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  double? tempKf;

  Main(
      {this.temp,
        this.feelsLike,
        this.tempMin,
        this.tempMax,
        this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'].toDouble();
    feelsLike = json['feels_like'].toDouble();
    tempMin = json['temp_min'].toDouble();
    tempMax = json['temp_max'].toDouble();
    tempKf = json['temp_kf'].toDouble();
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed']?.toDouble();
    deg = json['deg'];
    gust = json['gust']?.toDouble();
  }
}