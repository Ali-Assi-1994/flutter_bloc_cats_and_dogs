import 'package:bloc_test/bloc_test.dart';
import 'package:dogs_and_cats/src/bloc/cats/cats_bloc.dart';
import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dogs.dart';

class MockCatsRepo extends PetsRepository {
  MockCatsRepo() {
    baseUrl = '';
    apiKey = '';
  }

  @override
  Future<List<Pet>?> loadListOfPets({int? limit = 10, int? page = 0}) async {
    late List<Pet> dogs;
    try {
      dogs = dogsMockedJsonList
          .map(
            (i) => Pet.fromJson(i),
          )
          .toList()
          .sublist(page! * limit!, page * limit + limit);
    } catch (e) {
      throw (rangeError);
    }
    print('dogs.length: ${dogs.length} page: $page');
    return dogs;
  }
}
RangeError rangeError = RangeError.range(50, 40, 50,'end','Invalid Value');
void main() {
  group(
    'Testing CatsBloc',
    () {
      late CatsBloc bloc;
      setUp(() {
        bloc = CatsBloc(petsRepository: MockCatsRepo());
      });

      test(
        'Cats tab initial state',
        () => expect(bloc.state, const PetsState.empty()),
      );

      blocTest<CatsBloc, PetsState>(
        'first time fetch cats data',
        build: () => bloc,
        act: (bloc) => bloc.add(const LoadPetsListEvent()),
        expect: () => [
          const PetsState(isLoading: true, error: null, data: null),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 10),
          ),
        ],
      );

      blocTest<CatsBloc, PetsState>(
        'load more cats data',
        build: () => bloc,
        act: (bloc) {
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
          bloc.add(const LoadPetsListEvent());
        },
        expect: () => [
          const PetsState(isLoading: true, error: null, data: null),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 10),
          ),

          /// second patch
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 10),
          ),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 20),
          ),

          /// third patch
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 20),
          ),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 30),
          ),

          /// forth  patch
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 30),
          ),
          PetsState(
            isLoading: false,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 40),
          ),

          /// fifth empty  patch
          PetsState(
            isLoading: true,
            error: null,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 40),
          ),
          PetsState(
            isLoading: false,
            error: rangeError,
            data: dogsMockedJsonList.map((i) => Pet.fromJson(i)).toList().sublist(0, 40),
          ),
        ],
      );
    },
  );
}
