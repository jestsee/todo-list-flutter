import 'dart:developer';

import 'package:string_validator/string_validator.dart';
import 'package:todo_list/ui/validator/validation_message.dart';

class Validator {
  final ValidationMessage _msg = const ValidationMessage();
  String? email(String value) {
    if (value.isEmpty) return _msg.required('Email');
    if (!isEmail(value)) return _msg.email();
    return null;
  }

  String? name(String value) {
    if (value.isEmpty) return _msg.required('Name');
    return null;
  }

  String? password(String value) {
    if (value.isEmpty) return _msg.required('Password');
    if (!isAlphanumeric(value)) return _msg.alphaNumeric('Password');
    if (!isLength(value, 6)) return _msg.minLength('Password', 6);
    return null;
  }

  String? passwordNotMatch(String p1, String p2) {
    if (p1 != p2) return _msg.notMatch(['Password']);
    return null;
  }
}
