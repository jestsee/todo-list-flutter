class CustomException implements Exception {
  final String? message;

  const CustomException({this.message = 'Something went wrong!'});

  @override
  String toString() => "Custom exception {message: $message}";

  // TODO custom message 400 - unauthenticated
}
