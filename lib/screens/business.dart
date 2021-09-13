import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/shared.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var business = NewsAppCubit.get(context).business ;
    return  BlocConsumer<NewsAppCubit , NewsAppStates>(
      listener: (context , state){},
      builder: (context , state){
        return  ConditionalBuilder(
          condition:  business.length>0 ,
          builder: (context ){return ListView.builder(
              itemCount: business.length,
              itemBuilder: (context , index) {
             return  newsAppItems(business[index]  , context) ;
          }) ; } ,
          fallback: (context)=>Center(child: CircularProgressIndicator()),)  ;
      },
    )  ;
  }
}
