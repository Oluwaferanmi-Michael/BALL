class PolylineRoute {
  String code;
  List<Route> routes;
  List<Waypoint> waypoints;

  PolylineRoute({
    required this.code,
    required this.routes,
    required this.waypoints,
  });

  PolylineRoute copyWith({
    String? code,
    List<Route>? routes,
    List<Waypoint>? waypoints,
  }) => PolylineRoute(
    code: code ?? this.code,
    routes: routes ?? this.routes,
    waypoints: waypoints ?? this.waypoints,
  );

  PolylineRoute.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        routes = (json['routes'] as List)
            .map((e) => Route.fromJson(e as Map<String, dynamic>))
            .toList(),
        waypoints = (json['waypoints'] as List)
            .map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
            .toList();

            PolylineRoute.empty():code = '',
            routes = [],
            waypoints = [];
}

class Route {
  List<Leg> legs;
  String weightName;
  double weight;
  double duration;
  double distance;

  Route({
    required this.legs,
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
  });

  Route copyWith({
    List<Leg>? legs,
    String? weightName,
    double? weight,
    double? duration,
    double? distance,
  }) => Route(
    legs: legs ?? this.legs,
    weightName: weightName ?? this.weightName,
    weight: weight ?? this.weight,
    duration: duration ?? this.duration,
    distance: distance ?? this.distance,
  );

  Route.fromJson(Map<String, dynamic> json)
      : legs = (json['legs'] as List)
            .map((e) => Leg.fromJson(e as Map<String, dynamic>))
            .toList(),
        weightName = json['weight_name'] as String,
        weight = (json['weight'] as num).toDouble(),
        duration = (json['duration'] as num).toDouble(),
        distance = (json['distance'] as num).toDouble();
}

class Leg {
  List<dynamic> steps;
  double weight;
  String summary;
  double duration;
  double distance;

  Leg({
    required this.steps,
    required this.weight,
    required this.summary,
    required this.duration,
    required this.distance,
  });

  Leg copyWith({
    List<dynamic>? steps,
    double? weight,
    String? summary,
    double? duration,
    double? distance,
  }) => Leg(
    steps: steps ?? this.steps,
    weight: weight ?? this.weight,
    summary: summary ?? this.summary,
    duration: duration ?? this.duration,
    distance: distance ?? this.distance,
  );

  Leg.fromJson(Map<String, dynamic> json)
      : steps = json['steps'] as List<dynamic>,
        weight = (json['weight'] as num).toDouble(),
        summary = json['summary'] as String,
        duration = (json['duration'] as num).toDouble(),
        distance = (json['distance'] as num).toDouble();
}

class Waypoint {
  String hint;
  List<double> location;
  String name;
  double distance;

  Waypoint({
    required this.hint,
    required this.location,
    required this.name,
    required this.distance,
  });

  Waypoint copyWith({
    String? hint,
    List<double>? location,
    String? name,
    double? distance,
  }) => Waypoint(
    hint: hint ?? this.hint,
    location: location ?? this.location,
    name: name ?? this.name,
    distance: distance ?? this.distance,
  );

  Waypoint.fromJson(Map<String, dynamic> json)
      : hint = json['hint'] as String,
        location = (json['location'] as List).map((e) => e as double).toList(),
        name = json['name'] as String,
        distance = (json['distance'] as num).toDouble();
}
