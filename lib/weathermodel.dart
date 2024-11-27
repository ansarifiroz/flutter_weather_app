import 'dart:convert';

class ApiResponse {
  Location location;
  Current current;

  ApiResponse({
    required this.location,
    required this.current,
  });

  ApiResponse copyWith({
    Location? location,
    Current? current,
  }) =>
      ApiResponse(
        location: location ?? this.location,
        current: current ?? this.current,
      );

  factory ApiResponse.fromRawJson(String str) =>
      ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
      };
}

class Current {
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windKph;
  String windDir;
  int precipMm;
  int humidity;
  int cloud;
  double feelslikeF;
  int uv;

  Current({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDir,
    required this.precipMm,
    required this.humidity,
    required this.cloud,
    required this.feelslikeF,
    required this.uv,
  });

  Current copyWith({
    double? tempC,
    double? tempF,
    int? isDay,
    Condition? condition,
    double? windKph,
    String? windDir,
    int? precipMm,
    int? humidity,
    int? cloud,
    double? feelslikeF,
    int? uv,
  }) =>
      Current(
        tempC: tempC ?? this.tempC,
        tempF: tempF ?? this.tempF,
        isDay: isDay ?? this.isDay,
        condition: condition ?? this.condition,
        windKph: windKph ?? this.windKph,
        windDir: windDir ?? this.windDir,
        precipMm: precipMm ?? this.precipMm,
        humidity: humidity ?? this.humidity,
        cloud: cloud ?? this.cloud,
        feelslikeF: feelslikeF ?? this.feelslikeF,
        uv: uv ?? this.uv,
      );

  factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"]?.toDouble(),
        tempF: json["temp_f"]?.toDouble(),
        isDay: json["is_day"],
        condition: Condition.fromJson(json["condition"]),
        windKph: json["wind_kph"]?.toDouble(),
        windDir: json["wind_dir"],
        precipMm: json["precip_mm"],
        humidity: json["humidity"],
        cloud: json["cloud"],
        feelslikeF: json["feelslike_f"]?.toDouble(),
        uv: json["uv"],
      );

  Map<String, dynamic> toJson() => {
        "temp_c": tempC,
        "temp_f": tempF,
        "is_day": isDay,
        "condition": condition.toJson(),
        "wind_kph": windKph,
        "wind_dir": windDir,
        "precip_mm": precipMm,
        "humidity": humidity,
        "cloud": cloud,
        "feelslike_f": feelslikeF,
        "uv": uv,
      };
}

class Condition {
  String text;
  String icon;
  int code;

  Condition({
    required this.text,
    required this.icon,
    required this.code,
  });

  Condition copyWith({
    String? text,
    String? icon,
    int? code,
  }) =>
      Condition(
        text: text ?? this.text,
        icon: icon ?? this.icon,
        code: code ?? this.code,
      );

  factory Condition.fromRawJson(String str) =>
      Condition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"],
        icon: json["icon"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
        "code": code,
      };
}

class Location {
  String name;
  String region;
  String country;
  String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.localtime,
  });

  Location copyWith({
    String? name,
    String? region,
    String? country,
    String? localtime,
  }) =>
      Location(
        name: name ?? this.name,
        region: region ?? this.region,
        country: country ?? this.country,
        localtime: localtime ?? this.localtime,
      );

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        localtime: json["localtime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "localtime": localtime,
      };
}
