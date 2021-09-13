import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/shared.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController= TextEditingController() ;
    return BlocConsumer<NewsAppCubit ,NewsAppStates>(
      listener: (context , state){},
      builder: (context , state){
         List search = NewsAppCubit.get(context).search ;
        return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context ) ;
            },
            icon: Icon(Icons.arrow_back_ios , color: Colors.red,),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(22),
                child: TextFormField(
                  validator:
                      (String value){
                    if(value.isEmpty){
                      return " Please , Enter data " ;
                    }
                    else{
                      return null ;
                    }
                  },
                  // onChanged: (String value){
                  //   NewsAppCubit.get(context).getSearchData(value);
                  // },
                  onFieldSubmitted: (String value){
                    //value = searchController.text ;
                    NewsAppCubit.get(context).getSearchData(value);
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.search_rounded ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ) ,
                    labelText: "Search" ,
                  ),
                  keyboardType: TextInputType.text,
                  controller: searchController,
                ),
              ),
             SizedBox(height: 14,) ,
              if(state is NewsAppGetSearchDataLoadingState)
                Center(child: CircularProgressIndicator()) ,
               if(state is NewsAppGetSearchDataSuccessState)
                   ListView.builder(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemBuilder: (context , index)=> newsAppItems(search[index], context) ,
                      itemCount: search.length,
                    ) ,


            ],
          ),
        ) ,
      ) ; },
    );
  }
}
