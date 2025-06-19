class AppError {
  final String message;
  final String? stackTrace;

  const AppError({required this.message, this.stackTrace});
}

class LocationError extends AppError {
  const LocationError({
    super.message =
        'Cannot Retrieve User Location Please enable Location Services',
  });
}
