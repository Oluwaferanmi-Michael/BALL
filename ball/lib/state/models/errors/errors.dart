class AppError {
  final String message;
  final String? stackTrace;

  const AppError({required this.message, this.stackTrace});
}

class LocationError extends AppError {
  const LocationError({
    super.message =
        'Cannot Retrieve User Location Please enable Location Services, and check your internet connection',
  });
}

class NetworkError extends AppError {
  const NetworkError({
    super.message =
        'There seems to be a problem connecting to the internet. Please check your connection and try again.',
  });
}
