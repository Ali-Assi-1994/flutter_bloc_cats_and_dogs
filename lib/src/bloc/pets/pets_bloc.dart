import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsBloc extends Bloc<PetsEvents, PetsState> {
  PetsRepository petsRepository;

  PetsBloc({required this.petsRepository}) : super(const PetsState.empty()) {
    on<LoadPetsListEvent>(
      (event, emit) => {
        /// start loading
        emit(
          const PetsState(
            isLoading: true,
          ),
        ),
        /// call api
      petsRepository
      },
    );
  }
}
