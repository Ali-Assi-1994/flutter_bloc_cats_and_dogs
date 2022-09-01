import 'package:bloc_test/bloc_test.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_events.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_state.dart';
import 'package:dogs_and_cats/src/utils/auth_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Testing AuthBloc',
    () {
      late AuthBloc bloc;
      setUp(() {
        bloc = AuthBloc();
      });

      blocTest<AuthBloc, AuthState>(
        'AuthBloc init State',
        build: () => bloc,
        verify: (bloc) =>
            bloc.state ==
            const LoggedOutState(
              isLoading: false,
              authError: null,
            ),
      );

      /// test login
      String testEmail = 'test@course.bloc';
      String testUid = 'testUid';
      String testName = 'Ali';

      final user = MockUser(
        isAnonymous: false,
        uid: testUid,
        email: testEmail,
        displayName: testName,
      );

      final authLogin = MockFirebaseAuth(
        mockUser: user,
        signedIn: false,
      );

      blocTest<AuthBloc, AuthState>(
        'Test successful login',
        build: () => bloc,
        act: (bloc) => bloc.add(
          LoginEvent(email: '', password: '', firebaseAuth: authLogin),
        ),
        expect: () => [
          const LoggedOutState(isLoading: true),
          LoggedInState(isLoading: false, user: user),
        ],
      );

      final authWithLoginException = MockFirebaseAuth(
        mockUser: user,
        signedIn: false,
        authExceptions: AuthExceptions(
          signInWithEmailAndPassword: FirebaseAuthException(code: 'invalid-email'),
        ),
      );
      blocTest<AuthBloc, AuthState>(
        'Test failed login: invalid-email',
        build: () => bloc,
        act: (bloc) => bloc.add(
          LoginEvent(email: '', password: '', firebaseAuth: authWithLoginException),
        ),
        expect: () => [
          const LoggedOutState(isLoading: true),
          LoggedOutState(isLoading: false, authError: AuthError.from(FirebaseAuthException(code: 'invalid-email'))),
        ],
      );

      /// test sign up

      final mockSignUpUser = MockUser(
        uid: 'mock_uid',
        email: testEmail,
        displayName: 'Mock User',
      );

      final authSignup = MockFirebaseAuth(
        mockUser: mockSignUpUser,
        signedIn: false,
      );

      blocTest<AuthBloc, AuthState>(
        'Test successful signup',
        build: () => bloc,
        act: (bloc) => bloc.add(
          RegisterEvent(email: testEmail, password: '', firebaseAuth: authSignup),
        ),
        expect: () => [
          const LoggedOutState(isLoading: true),
          LoggedInState(isLoading: false, user: mockSignUpUser),
        ],
      );

      final authWithSignupException = MockFirebaseAuth(
        mockUser: mockSignUpUser,
        signedIn: false,
        authExceptions: AuthExceptions(
          createUserWithEmailAndPassword: FirebaseAuthException(code: 'invalid-email'),
        ),
      );

      blocTest<AuthBloc, AuthState>(
        'Test failed signup: invalid-email',
        build: () => bloc,
        act: (bloc) => bloc.add(
          RegisterEvent(email: '', password: '', firebaseAuth: authWithSignupException),
        ),
        expect: () => [
          const LoggedOutState(isLoading: true),
          LoggedOutState(isLoading: false, authError: AuthError.from(FirebaseAuthException(code: 'invalid-email'))),
        ],
      );
    },
  );
}
