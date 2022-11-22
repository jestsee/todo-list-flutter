import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// controller - name, email, password, password confirm
// focus - name, email, password, password confirm
// password sama password confirm ada state buat hide/show

class BaseField {
  final TextEditingController controller;
  final focus = useMemoized(() => FocusNode());
  final touched = useState(false);

  BaseField(this.controller) {
    useEffect(() {
      log('terpanggil');
      focus.addListener(() {
        if (focus.hasFocus) {
          log('berubah true');
          touched.value = true;
        }
      });

      return () => focus.dispose();
    }, []);
  }
}

class SignUpFields {
  final BaseField name;
  final BaseField email;
  final BaseField password;
  final BaseField passwordConfirm;

  final _hidePassword = useState(false);
  final _hideConfirmPassword = useState(false);

  SignUpFields(this.name, this.email, this.password, this.passwordConfirm);

  void togglePassword() {
    _hidePassword.value = !_hidePassword.value;
  }

  void toggleConfirmPassword() {
    _hideConfirmPassword.value = !_hideConfirmPassword.value;
  }

  bool get hidePassword => _hidePassword.value;
  bool get hideConfirmPassword => _hideConfirmPassword.value;
}

SignUpFields useSignUp() {
  final name = BaseField(useTextEditingController(text: ''));
  final email = BaseField(useTextEditingController(text: ''));
  final password = BaseField(useTextEditingController(text: ''));
  final passwordConfirm = BaseField(useTextEditingController(text: ''));

  return SignUpFields(name, email, password, passwordConfirm);
}
