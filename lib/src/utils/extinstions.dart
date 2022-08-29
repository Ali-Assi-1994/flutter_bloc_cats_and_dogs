import 'package:dogs_and_cats/src/bloc/pets/models/breed_model.dart';

extension ExtractTemperamentFromBreeds on List<Breed?> {
  String extractTemperamentFromBreeds() {
    String s = '';
    if (isNotEmpty) {
      for (var breed in this) {
        if (breed!.temperament != null) {
          s = s + breed.temperament!;
        }
      }
    }
    return s;
  }
}
