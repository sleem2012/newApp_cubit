import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/layout/cubit/states.dart';
import 'package:news_cubit/modules/business_screen.dart';
import 'package:news_cubit/modules/science_screen.dart';
import 'package:news_cubit/modules/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        label: "Business",
        icon: Icon(
          Icons.business,
        )),
    BottomNavigationBarItem(
        label: "Sports",
        icon: Icon(
          Icons.sports,
        )),
    BottomNavigationBarItem(
        label: "Science",
        icon: Icon(
          Icons.science,
        )),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }
}
