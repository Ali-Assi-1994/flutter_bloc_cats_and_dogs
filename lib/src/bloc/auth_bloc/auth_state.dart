import 'package:dogs_and_cats/src/utils/auth_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
abstract class AuthState {
  final bool isLoading;
  final AuthError? authError;

  const AuthState({
    required this.isLoading,
    this.authError,
  });
}

@immutable
class LoggedInState extends AuthState {
  final User? user;

  const LoggedInState({
    required bool isLoading,
    required this.user,
  }) : super(
          isLoading: isLoading,
          authError: null,
        );
}

@immutable
class LoggedOutState extends AuthState {
  const LoggedOutState({
    required bool isLoading,
    AuthError? authError,
  }) : super(
          isLoading: isLoading,
          authError: authError,
        );
}
