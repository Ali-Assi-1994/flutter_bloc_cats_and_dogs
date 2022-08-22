import 'package:dogs_and_cats/generated/l10n.dart';
import 'package:dogs_and_cats/src/bloc/cats/cats_bloc.dart';
import 'package:dogs_and_cats/src/bloc/dogs/dogs_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_bloc.dart';
import 'package:dogs_and_cats/src/bloc/home/home_events.dart';
import 'package:dogs_and_cats/src/bloc/home/home_state.dart';
import 'package:dogs_and_cats/src/ui/pets_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (selectedTab) {
              switch (selectedTab) {
                case 0:
                  context.read<HomeBloc>().add(const SelectedDogsTabEvent());
                  break;
                case 1:
                  context.read<HomeBloc>().add(const SelectedCatsTabEvent());
                  break;
              }
            },
            currentIndex: state.selectedTab,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: S.of(context).dogs,
                icon: const Icon(Icons.height),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                label: S.of(context).cats,
                icon: const Icon(Icons.subject),
              ),
            ],
          ),
          body: state.selectedTab == 0 ? const PetsListPage<DogsBloc>() : const PetsListPage<CatsBloc>(),
        );
      },
    );
  }
}
