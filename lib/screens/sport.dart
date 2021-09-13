import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/shared.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sports = NewsAppCubit.get(context).sports ;
    return  BlocConsumer<NewsAppCubit , NewsAppStates>(
      listener: (context , state){},
      builder: (context , state){
        return  ConditionalBuilder(
          condition:  sports.length>0 ,
          builder: (context ){return
            ListView.builder(
                physics: BouncingScrollPhysics(),
              itemCount: sports.length,
              itemBuilder: (context , index) {
                return  newsAppItems(sports[index], context ) ;
              })
          ; } ,
          fallback: (context)=>Center(child: CircularProgressIndicator()),)  ;
      },
    )  ;
  }
}
