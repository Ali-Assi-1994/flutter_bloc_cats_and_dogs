import 'package:dogs_and_cats/src/bloc/pets/pet_model.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_bloc.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_events.dart';
import 'package:dogs_and_cats/src/bloc/pets/pets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetsListPage<T extends PetsBloc> extends StatelessWidget {
  const PetsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<T>().add(const LoadPetsListEvent());
    return Scaffold(
      appBar: AppBar(),
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
    return Image.network(pet.url);
  }
}
