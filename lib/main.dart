import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_application/shared/network/local/cache_helper.dart';
import 'package:news_application/shared/network/remote/dio_helper.dart';
import 'layout/home_layout.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final dark = HexColor('121212');
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? isDark = CacheHelper.getData(key: 'isDark');
    debugPrint(isDark.toString());
    return BlocProvider(
      create: (ctx) => AppCubit()
        ..getBusiness()
        ..startMode(isDark),
      child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    color: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange)),
              darkTheme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: dark,
                  appBarTheme: AppBarTheme(
                    iconTheme: const IconThemeData(color: Colors.white),
                    color: dark,
                    elevation: 0.0,
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: dark,
                      elevation: 20.0),
                  textTheme: const TextTheme(
                      bodyText2: TextStyle(color: Colors.white))),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const HomeLayout(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
