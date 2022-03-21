import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';


class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
         return BlocConsumer<AppCubit,AppStates>(
        builder: (context, state) {
          var list = AppCubit.get(context).sports;
          return articleBuilder(list);
        },
        listener: (context, state) {});

  }
}
