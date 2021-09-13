import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/shared.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var science = NewsAppCubit.get(context).science ;
    return  BlocConsumer<NewsAppCubit , NewsAppStates>(
      listener: (context , state){},
      builder: (context , state){
        return  ConditionalBuilder(
          condition:  science.length>0 ,
          builder: (context ){
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: science.length,
              itemBuilder: (context , index) {
                return  newsAppItems(science[index], context ) ;
              }) ; } ,
          fallback: (context)=>Center(child: CircularProgressIndicator()),)  ;
      },
    ) ;
  }
}
