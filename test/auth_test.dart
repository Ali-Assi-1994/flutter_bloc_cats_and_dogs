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
      late AuthBloc loginBloc;

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
      setUp(() {
        loginBloc = AuthBloc(authLogin);
      });

      test('AuthBloc initial state', () {
        expect(
            loginBloc.state,
            const LoggedOutState(
              isLoading: false,
              authError: null,
            ));
      });

      blocTest<AuthBloc, AuthState>(
        'Test successful login',
        build: () => loginBloc,
        act: (loginBloc) => loginBloc.add(
          const LoginEvent(email: '', password: ''),
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
        build: () => AuthBloc(authWithLoginException),
        act: (bloc) => bloc.add(
          const LoginEvent(email: '', password: ''),
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
        build: () => AuthBloc(authSignup),
        act: (bloc) => bloc.add(
          RegisterEvent(
            email: testEmail,
            password: '',
          ),
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
        build: () => AuthBloc(authWithSignupException),
        act: (bloc) => bloc.add(
          const RegisterEvent(email: '', password: ''),
        ),
        expect: () => [
          const LoggedOutState(isLoading: true),
          LoggedOutState(isLoading: false, authError: AuthError.from(FirebaseAuthException(code: 'invalid-email'))),
        ],
      );
    },
  );
}
