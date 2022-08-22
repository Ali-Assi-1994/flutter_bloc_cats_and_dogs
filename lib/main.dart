import 'package:dogs_and_cats/generated/l10n.dart';
import 'package:dogs_and_cats/src/bloc/cats/cats_bloc.dart';
import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/data_layer/pets_repository/pets_repository.dart';
import 'package:dogs_and_cats/src/ui/home_page.dart';
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
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<DogsRepo>(create: (context) => DogsRepo()),
          RepositoryProvider<CatsRepo>(create: (context) => CatsRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(),
            ),
            BlocProvider<DogsBloc>(
              create: (context) => DogsBloc(petsRepository: context.read<DogsRepo>()),
            ),
            BlocProvider<CatsBloc>(
              create: (context) => CatsBloc(petsRepository: context.read<CatsRepo>()),
            )
          ],
          child: const HomePage(),
        ),
      ),
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
