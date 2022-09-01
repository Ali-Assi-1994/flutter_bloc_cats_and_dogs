import 'package:bloc_test/bloc_test.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:dogs_and_cats/src/bloc/auth_bloc/auth_state.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing AuthBloc', () {
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
  });

  group('Testing Firebase Authentication', () async {
    final user = MockUser(
      isAnonymous: false,
      uid: 'testUserID',
      email: 'test@course.bloc',
      displayName: 'Ali',
    );
    final auth = MockFirebaseAuth(mockUser: user, signedIn: false);
       // final result = await auth.signInWithCredential(credential);
    //    final user = await result.user;
  });
}
