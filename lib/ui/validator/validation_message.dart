class ValidationMessage {
  const ValidationMessage();

  String email() => 'Please enter a valid email address';

  String required(String field) => '$field is required';

  String minLength(String field, int length) => '$field should be more than $length characters';

  String maxLength(String field, int length) => '$field can be max $length characters long';

  String alphaNumeric(String field) => '$field should be alphanumeric only';
}