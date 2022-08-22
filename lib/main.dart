import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';
import 'package:dogs_and_cats/src/ui/pets_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (_) => DogsRepo(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<DogsBloc>(
              create: (context) => DogsBloc(petsRepository: context.read<DogsRepo>()),
            )
          ],
          child: const PetsListPage<DogsBloc>(),
        ),
      ),
    );
  }
}
