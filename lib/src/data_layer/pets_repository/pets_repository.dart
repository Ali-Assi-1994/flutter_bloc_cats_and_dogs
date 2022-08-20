import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_service.dart';

abstract class PetsRepository {
  final PetsService service;

  const PetsRepository({required this.service});
}
