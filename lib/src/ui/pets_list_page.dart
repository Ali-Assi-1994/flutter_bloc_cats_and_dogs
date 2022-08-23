import 'package:dogs_and_cats/src/bloc/pets/models/breed_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/models/pet_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_bloc.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PetsListPage<T extends PetsBloc> extends StatelessWidget {
  const PetsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<T, PetsState>(
        builder: (context, state) {
          if (!state.isLoading && (state.data == null || state.data!.isEmpty)) {
            context.read<T>().add(const LoadPetsListEvent());
          }
          if (state.isLoading && (state.data == null || state.data!.isEmpty)) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Text('error ${state.error.toString()}');
          }
          if (state.data != null && state.data!.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (ScrollEndNotification scrollInfo) {
                      if (!state.isLoading && scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 100) {
                        context.read<T>().add(const LoadPetsListEvent());
                        return true;
                      }
                      return false;
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: state.data!.length,
                      itemBuilder: (context, index) {
                        return PetItemBuilder(pet: state.data![index]);
                      },
                    ),
                  ),
                ),
                if (state.isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: CircularProgressIndicator(color: Colors.black),
                    ),
                  ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class PetItemBuilder extends StatelessWidget {
  final Pet pet;

  const PetItemBuilder({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          PetImageBuilder(imageUrl: pet.url),
          PetBreedsTagsBuilder(breeds: pet.breeds!),
          PetTemperamentText(pet: pet),
          Text(
            pet.breeds != null && pet.breeds!.isNotEmpty ? pet.breeds!.first!.bredFor ?? '' : "",
            style: TextStyle(color: Colors.yellow),
          ),
          Text(
            pet.breeds != null && pet.breeds!.isNotEmpty ? pet.breeds!.first!.origin ?? '' : "",
            style: TextStyle(color: Colors.red),
          ),
          Text(
            pet.breeds != null && pet.breeds!.isNotEmpty ? pet.breeds!.first!.description ?? '' : "",
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}

class PetImageBuilder extends StatelessWidget {
  final String imageUrl;

  const PetImageBuilder({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        imageUrl,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Padding(
            padding: const EdgeInsets.all(80.0),
            child: SizedBox(
              width: 90,
              height: 90,
              child: Shimmer.fromColors(
                baseColor: const Color(0xFFF4F4F4),
                direction: ShimmerDirection.rtl,
                highlightColor: const Color(0xFFDADADA),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset("assets/icons/paws.png"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PetBreedsTagsBuilder extends StatelessWidget {
  final List<Breed?> breeds;

  const PetBreedsTagsBuilder({
    Key? key,
    required this.breeds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: breeds
              .map((breed) => ActionChip(
                    label: Text(
                      breed!.name ?? "I'm just a baby!",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () {},
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class PetTemperamentText extends StatelessWidget {
  final Pet pet;

  const PetTemperamentText({
    Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Text(extractTemperamentFromBreeds(pet.breeds))),
      ],
    );
  }

  String extractTemperamentFromBreeds(List<Breed?>? breeds) {
    String s = '';
    if (breeds != null && pet.breeds!.isNotEmpty) {
      for (var breed in breeds) {
        if (breed!.temperament != null) {
          s = s + breed.temperament!;
        }
      }
    }
    return s;
  }
}
