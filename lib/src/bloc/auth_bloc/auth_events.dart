import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
abstract class AuthEvents {
  const AuthEvents();
}

@immutable
class LoginEvent implements AuthEvents {
  final String email;
  final String password;
  final FirebaseAuth firebaseAuth;

  const LoginEvent({
    required this.email,
    required this.password,
    required this.firebaseAuth,
  });
}

@immutable
class RegisterEvent implements AuthEvents {
  final String email;
  final String password;

  const RegisterEvent({
    required this.email,
    required this.password,
  });
}
