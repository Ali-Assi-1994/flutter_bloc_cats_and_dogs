import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/data_layer/Dio/api.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_service.dart';
import 'package:dogs_and_cats/src/utils/constants.dart';

class PetsRepository {
  PetsRepository();

  late String baseUrl;
  late String apiKey;
  late PetsService service = PetsService(baseUrl: baseUrl, apiKey: apiKey);

  Future<List<dynamic>?> loadListOfPets({int? limit = 10, int? page = 0 }) async {
    ApiResult result = await service.loadListOfPets(limit: limit,page: page);
    if (result.type == ApiResultType.success) {
      return result.data.map((i) => Pet.fromJson(i)).toList();
    } else {
      throw result.errorMessage;
    }
  }
}

class DogsRepo extends PetsRepository {
  DogsRepo() {
    baseUrl = 'https://api.thedogapi.com/';
    apiKey = Constants.dogApiKey;
  }
}

class CatsRepo extends PetsRepository {
  CatsRepo() {
    baseUrl = 'https://api.thecatapi.com/';
    apiKey = Constants.catApiKey;
  }
}
