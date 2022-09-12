import 'package:flutter_weather_app/src/models/forecast.model.dart';

class ReportModel {
  String? cod;
  int? message;
  int? cnt;
  List<ForecastModel>? list;
  City? city;

  ReportModel({this.cod, this.message, this.cnt, this.list});

  ReportModel.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <ForecastModel>[];
      json['list'].forEach((v) {
        list!.add(ForecastModel.fromJson(v));
      });
    }
    if (json['city'] != null) {
      city = City.fromJson(json['city']);
    }
  }
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;

  City({this.id, this.name, this.coord, this.country});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    data['country'] = country;
    return data;
  }
}

class Coord {
  double? lat;
  double? lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
