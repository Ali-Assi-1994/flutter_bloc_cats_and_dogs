import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Testing HomeBloc init state',
    () {
      late HomeBloc bloc;
      setUp(() {
        bloc = HomeBloc();
      });
      test(
        'initial state',
        () {
          expect(bloc.state, const HomeState(selectedTab: 0));
        },
      );
    },
  );
}
