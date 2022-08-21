import 'package:dogs_and_cats/src/data_layer/Dio/api.dart';

class PetsService {
  final String url;

  PetsService({required this.url});

  late ApiClient petApiClient = ApiClient(baseUrl: url);

  Future<ApiResult> loadListOfPets() async {
    return petApiClient.get(url: url);
  }
}
