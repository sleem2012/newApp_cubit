import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cubit/layout/cubit/cubit.dart';
import 'package:news_cubit/layout/cubit/states.dart';
import 'package:news_cubit/shared/components/component.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){

        var List = NewsCubit.get(context).search;
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                onChange: (value) {

                  NewsCubit.get(context).getSearch(value);
                },
                controller: searchController,
                type: TextInputType.text,
                validate: (String value) {
                  if (value.isEmpty) {
                    return "search must not be empty";
                  }
                  return null;
                },
                label: 'Search',
                prefix: Icons.search,
              ),
            ),
            Expanded(child: articleBuilder(List, context,isSearch: true))
          ],
        ),
      );
      },

    );
  } 
}
