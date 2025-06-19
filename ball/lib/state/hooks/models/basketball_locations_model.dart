import 'package:ball/state/models/locations.dart';

class BasketballLocations {
  String title;
  dynamic price;
  String categoryName;
  String address;
  String neighborhood;
  String street;
  String city;
  String state;
  String phone;
  String phoneUnformatted;
  Coordinates location;
  double totalScore;
  bool permanentlyClosed;
  bool temporarilyClosed;
  String placeId;
  int reviewsCount;
  int imagesCount;
  List<OpeningHour> openingHours;
  List<dynamic> placesTags;
  List<dynamic> gasPrices;
  String language;
  int rank;
  String imageUrl;

  BasketballLocations({
    required this.title,
    required this.price,
    required this.categoryName,
    required this.address,
    required this.neighborhood,
    required this.street,
    required this.city,
    required this.state,
    required this.phone,
    required this.phoneUnformatted,
    required this.location,
    required this.totalScore,
    required this.permanentlyClosed,
    required this.temporarilyClosed,
    required this.placeId,
    required this.reviewsCount,
    required this.imagesCount,
    required this.openingHours,
    required this.placesTags,
    required this.gasPrices,
    required this.language,
    required this.rank,
    required this.imageUrl,
  });

  BasketballLocations copyWith({
    String? title,
    dynamic price,
    String? categoryName,
    String? address,
    String? neighborhood,
    String? street,
    String? city,
    String? state,
    String? phone,
    String? phoneUnformatted,
    Coordinates? location,
    double? totalScore,
    bool? permanentlyClosed,
    bool? temporarilyClosed,
    String? placeId,
    int? reviewsCount,
    int? imagesCount,
    List<OpeningHour>? openingHours,
    List<dynamic>? placesTags,
    List<dynamic>? gasPrices,
    String? language,
    int? rank,
    String? imageUrl,
  }) => BasketballLocations(
    title: title ?? this.title,
    price: price ?? this.price,
    categoryName: categoryName ?? this.categoryName,
    address: address ?? this.address,
    neighborhood: neighborhood ?? this.neighborhood,
    street: street ?? this.street,
    city: city ?? this.city,
    state: state ?? this.state,
    phone: phone ?? this.phone,
    phoneUnformatted: phoneUnformatted ?? this.phoneUnformatted,
    location: location ?? this.location,
    totalScore: totalScore ?? this.totalScore,
    permanentlyClosed: permanentlyClosed ?? this.permanentlyClosed,
    temporarilyClosed: temporarilyClosed ?? this.temporarilyClosed,
    placeId: placeId ?? this.placeId,
    reviewsCount: reviewsCount ?? this.reviewsCount,
    imagesCount: imagesCount ?? this.imagesCount,
    openingHours: openingHours ?? this.openingHours,
    placesTags: placesTags ?? this.placesTags,
    gasPrices: gasPrices ?? this.gasPrices,
    language: language ?? this.language,
    rank: rank ?? this.rank,
    imageUrl: imageUrl ?? this.imageUrl,
  );

  BasketballLocations.fromJson(Map<String, dynamic> json)
    : title = json['title'] ?? '',
      price = json['price'] ?? '',
      categoryName = json['categoryName'] ?? '',
      address = json['address'] as String,
      neighborhood = json['neighborhood'] ?? '',
      street = json['street'] ?? '',
      city = json['city'] ?? '',
      state = json['state'] ?? '',
      phone = json['phone'] ?? '',
      phoneUnformatted = json['phoneUnformatted'] ?? '',
      location = Coordinates.fromJson(json['location']),
      totalScore = (json['totalScore'] ?? 0).toDouble(),
      permanentlyClosed = json['permanentlyClosed'] ?? false,
      temporarilyClosed = json['temporarilyClosed'] ?? false,
      placeId = json['placeId'] ?? '',
      reviewsCount = (json['reviewsCount'] ?? 0) as int,
      imagesCount = (json['imagesCount'] ?? 0) as int,
      openingHours = (json['openingHours'] as List<dynamic>)
          .map((e) => OpeningHour.fromJson(e))
          .toList(),
      placesTags = (json['placesTags'] ?? []) as List<dynamic>,
      gasPrices = (json['gasPrices'] ?? []) as List<dynamic>,
      language = json['language'] as String,
      rank = (json['rank'] ?? 0) as int,
      imageUrl = (json['imageUrl'] ?? '') as String;
}

class OpeningHour {
  String day;
  String hours;

  OpeningHour({required this.day, required this.hours});

  OpeningHour copyWith({String? day, String? hours}) =>
      OpeningHour(day: day ?? this.day, hours: hours ?? this.hours);

  OpeningHour.fromJson(Map<String, dynamic> json)
    : day = json['day'] as String,
      hours = json['hours'] as String;
}
