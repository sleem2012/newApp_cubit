import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/layout/cubit/states.dart';
import 'package:news_cubit/modules/business_screen.dart';
import 'package:news_cubit/modules/science_screen.dart';
import 'package:news_cubit/modules/sports_screen.dart';
import 'package:news_cubit/shared/network/local/cache_helper.dart';
import 'package:news_cubit/shared/network/remote/dio_helper.dart';

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

    if (index == 0) getBusiness();

    if (index == 1) getSports();

    if (index == 2) getScience();
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError(
      (error) {
        emit(NewsGetBusinessErrorState(error.toString()));
        print(error.toString());
      },
    );
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]["title"]);
        emit(NewsGetSportsSuccessState());
      }).catchError(
        (error) {
          emit(NewsGetSportsErrorState(error.toString()));
          print(error.toString());
        },
      );
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]["title"]);
        emit(NewsGetScienceSuccessState());
      }).catchError(
        (error) {
          emit(NewsGetScienceErrorState(error.toString()));
          print(error.toString());
        },
      );
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }



  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;

      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
      emit(NewsChangeModeState());
    }
  }
List<dynamic>search=[];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search=[];


    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]["title"]);
      emit(NewsGetSearchSuccessState());
    }).catchError(
          (error) {
        emit(NewsGetSearchErrorState(error.toString()));
        print(error.toString());
      },
    );
  }



}
