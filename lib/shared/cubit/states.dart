abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppGetBusinessLoadingState extends AppStates {}

class AppGetBusinessSuccessState extends AppStates {}

class AppGetBusinessErrorState extends AppStates {
  final String error;
  AppGetBusinessErrorState(this.error);
}
class AppGetSportsLoadingState extends AppStates {}

class AppGetSportsSuccessState extends AppStates {}

class AppGetSportsErrorState extends AppStates {
  final String error;
  AppGetSportsErrorState(this.error);
}
class AppGetScienceLoadingState extends AppStates {}

class AppGetScienceSuccessState extends AppStates {}

class AppGetScienceErrorState extends AppStates {
  final String error;
  AppGetScienceErrorState(this.error);
}
class AppChangeMode extends AppStates {}

