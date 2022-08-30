import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_events.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthBloc()
      : super(const LoggedOutState(
          isLoading: false,
          authError: null,
        )) {
    on<LoginEvent>(
      (event, emit) async {
        /// start loading
        emit(
          const LoggedOutState(
            isLoading: true,
            authError: false,
          ),
        );

        /// try to login
        try {
          final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          final user = userCredential.user!;
          emit(
            LoggedInState(
              isLoading: false,
              user: user,
            ),
          );
        } catch (error) {
          emit(
            LoggedOutState(
              isLoading: false,
              authError: error,
            ),
          );
        }
      },
    );

    on<RegisterEvent>(
      (event, emit) async {
        /// start loading
        emit(
          const LoggedOutState(
            isLoading: true,
            authError: false,
          ),
        );

        /// try to register user
        try {
          final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          final user = userCredential.user!;
          emit(
            LoggedInState(
              isLoading: false,
              user: user,
            ),
          );
        } catch (error) {
          emit(
            LoggedOutState(
              isLoading: false,
              authError: error,
            ),
          );
        }
      },
    );
  }
}
