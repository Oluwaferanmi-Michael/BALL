import 'package:ball/state/data/location_service.dart';
import 'package:ball/state/models/errors/errors.dart';

import 'package:ball/state/models/locations.dart';
import 'package:ball/state/provider/check_internet_connection_provider.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dartz/dartz.dart';

part 'user_location_provider.g.dart';

@riverpod
Future<Either<AppError, UserLocation>> userLocation(Ref ref) async {
  final locationService = LocationService();

  try {
    final internet = ref.watch(checkInternetConnectionProvider).value;

    if (internet == false) {return const Left(NetworkError());}

    final location = await locationService.fetchCurrentLocation();

    if (location == null) {
      return const Left(LocationError());
    }

    final userLocation = UserLocation(
      lat: location.latitude,
      lng: location.longitude,
    );

    return Right(userLocation);
  } catch (err) {
    return Left(
      AppError(message: 'An unexpected error occurred: ${err.toString()}'),
    );
  }
}
