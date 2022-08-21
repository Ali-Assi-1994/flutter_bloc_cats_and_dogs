import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_service.dart';

abstract class PetsRepository {
  PetsRepository();

  late String url;
  late PetsService service = PetsService(url: url);
}

class DogsRepo extends PetsRepository {
  DogsRepo() {
    url = 'dogsUrl';
  }
}
