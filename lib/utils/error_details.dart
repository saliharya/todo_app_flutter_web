class ErrorDetails implements Exception {
  final String message;
  final String? details;

  ErrorDetails({required this.message, this.details});
}