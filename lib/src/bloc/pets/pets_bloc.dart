import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsBloc extends Bloc<PetsEvents, PetsState> {
  PetsBloc() : super(const PetsState.empty()) {
    on<LoadPetsListEvent>(
      (event, emit) => {},
    );
  }
}
