import 'package:disney_characters/presentation/favourite/favourites_page.dart';
import 'package:disney_characters/presentation/list/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite/bloc/favourite_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage.withCubit(),
          FavouritesPage.withCubit(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.deepPurpleAccent,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            context.read<FavouriteCubit>().loadFavourite();
          }
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
