import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/layout/cubit/cubit.dart';
import 'package:news_cubit/layout/cubit/states.dart';
import 'package:news_cubit/shared/components/component.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var List=NewsCubit.get(context).business;
        return articleBuilder(List, context);
      },
    );
  }
}
