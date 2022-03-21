import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/shared/cubit/states.dart';
import 'package:news_application/shared/network/local/cache_helper.dart';

import '../../modules/business.dart';
import '../../modules/science.dart';
import '../../modules/sports.dart';
import '../components/constants.dart';
import '../network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  int currentIndex = 0;
  bool isDark = false;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(AppChangeBottomNavBarState());
  }

  void getBusiness() {
    emit(AppGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(url: Constants.PATH, query: Constants.BUSINESS_QUERY)
          .then((value) {
        business = value.data['articles'];
        emit(AppGetBusinessSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(AppGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(AppGetBusinessSuccessState());
    }
  }

  void getSports() {
    emit(AppGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: Constants.PATH, query: Constants.SPORTS_QUERY)
          .then((value) {
        sports = value.data['articles'];
        debugPrint(sports[0]);
        emit(AppGetSportsSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(AppGetSportsErrorState(error.toString()));
      });
    } else {
      emit(AppGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(AppGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: Constants.PATH, query: Constants.SCIENCE_QUERY)
          .then((value) {
        science = value.data['articles'];
        debugPrint(science[0]);
        emit(AppGetSportsSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(AppGetScienceErrorState(error.toString()));
      });
    } else {
      emit(AppGetScienceSuccessState());
    }
  }
  void getSearch(String value){
    emit(AppGetSearchLoadingState());
    search=[];
    DioHelper.getData(url: 'v2/everything', query: {'q': value,'apiKey':Constants.API_KEY})
        .then((value) {
      search = value.data['articles'];
      debugPrint(search[0]);
      emit(AppGetSearchSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(AppGetSearchErrorState(error.toString()));
    });
  }

  void changeMode() {
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark)
        .then((value) => emit(AppChangeMode()));
  }
  void startMode(fromShared) {
      if(fromShared!=null){
        isDark=fromShared;
        emit(AppChangeMode());
      }
  }
}
