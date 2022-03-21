import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('NewsApp'),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.brightness_4_outlined), onPressed: () {AppCubit.get(context).changeMode();})
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: cubit.bottomItems),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
