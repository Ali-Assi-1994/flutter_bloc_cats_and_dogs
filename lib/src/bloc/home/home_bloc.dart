import 'package:dogs_and_cats/src/bloc/home/home_events.dart';
import 'package:dogs_and_cats/src/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  HomeBloc() : super(const HomeState(selectedTab: 0)) {
    on<SelectedDogsTabEvent>(
      (event, emit) async {
        emit(const HomeState(selectedTab: 0));
      },
    );

    on<SelectedCatsTabEvent>(
      (event, emit) async {
        emit(const HomeState(selectedTab: 1));
      },
    );

  }
}
