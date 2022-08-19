import 'package:dogs_and_cats/src/pets/pets_service.dart';

abstract class PetsRepository {
  final PetsService service;

  const PetsRepository({required this.service});
}
