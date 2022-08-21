import 'package:dogs_and_cats/src/bloc/pets/pet_model.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class PetsState {
  final bool isLoading;
  final List<Pet>? data;
  final Object? error;

  const PetsState({
    required this.isLoading,
    this.data,
    this.error,
  });

  const PetsState.empty()
      : isLoading = false,
        data = null,
        error = null;
}
