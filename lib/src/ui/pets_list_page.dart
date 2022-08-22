import 'package:dogs_and_cats/src/bloc/pets/breed_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/pet_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_bloc.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PetsListPage<T extends PetsBloc> extends StatelessWidget {
  const PetsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<T>().add(const LoadPetsListEvent());
    return Scaffold(
      body: BlocBuilder<T, PetsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Text('error ${state.error.toString()}');
          }
          if (state.data != null && state.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: state.data!.length,
              itemBuilder: (context, index) {
                return PetItemBuilder(pet: state.data![index]);
              },
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
          PetImageBuilder(imageUrl: pet.url),
          PetBreedsTagsBuilder(breeds: pet.breeds!),
          Text(pet.breeds != null && pet.breeds!.isNotEmpty ? pet.breeds!.first!.temperament??'' :''),
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
    return Image.network(
      imageUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
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
        );
      },
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
