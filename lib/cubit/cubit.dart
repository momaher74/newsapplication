import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/network/cachehelper.dart';
import 'package:newsapp/network/diohelper.dart';
import 'package:newsapp/screens/business.dart';
import 'package:newsapp/screens/science.dart';
import 'package:newsapp/screens/sport.dart';

class NewsAppCubit extends Cubit<NewsAppStates>
{
  NewsAppCubit() : super(NewsAppInitialState());
  static NewsAppCubit get(context)=>BlocProvider.of(context) ;
 var currentIndex = 0 ;
 List<Widget> screens = [ BusinessScreen() , SportsScreen() , ScienceScreen()];
 void changeNavBar(index)
 {
   // emit(NewsAppNavBar2State()) ;
   currentIndex = index ;
  emit(NewsAppNavBarState()) ;
 }
 //  abdallahApiKey  country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
  List business = [] ;
  List sports = [] ;
  List science = [] ;
 getBusinessData(){
   emit(NewsAppGetBusinessDataLoadingState()) ;
   DioHelper.getData(url: "top-headlines" , query: {
     "country":"eg" ,
     "category":"business" ,
     "apiKey":"91a4b6e7efb64e7ca6dcfd2d046faef5" ,
   }).then((value) {
     print("business has come ${value.data.toString()}") ;
     business = value.data['articles'] ;
     emit(NewsAppGetBusinessDataSuccessState()) ;
   }).catchError((error){
     emit(NewsAppGetBusinessDataErrorState()) ;
   }) ;
}
  getSportsData(){
    emit(NewsAppGetSportsDataLoadingState()) ;
    DioHelper.getData(url: "top-headlines" , query: {
      "country":"eg" ,
      "category":"sports" ,
      "apiKey":"91a4b6e7efb64e7ca6dcfd2d046faef5" ,
    }).then((value) {
      print(value.data.toString()) ;
      business = value.data['articles'] ;
      emit(NewsAppGetSportsDataSuccessState()) ;
    }).catchError((error){
      emit(NewsAppGetSportsDataErrorState()) ;
    }) ;
  }
  getScienceData(){
    emit(NewsAppGetScienceDataLoadingState()) ;
    DioHelper.getData(url: "top-headlines" , query: {
      "country":"eg" ,
      "category":"science" ,
      "apiKey":"91a4b6e7efb64e7ca6dcfd2d046faef5" ,
    }).then((value) {
      print(value.data.toString()) ;
      science = value.data['articles'] ;
      emit(NewsAppGetScienceDataSuccessState()) ;
    }).catchError((error){
      emit(NewsAppGetScienceDataErrorState()) ;
    }) ;
  }
  List search = [] ;
  getSearchData( String value ){
    search = [] ;
    emit(NewsAppGetSearchDataLoadingState()) ;
    DioHelper.getData(
        url: "everything" ,
        query: {
      "q":"$value" ,
      "apiKey":"91a4b6e7efb64e7ca6dcfd2d046faef5" ,
    }).then((value)
    {
      search = value.data['articles'] ;
      emit(NewsAppGetSearchDataSuccessState()) ;
    }).catchError((error){
      emit(NewsAppGetSearchDataErrorState()) ;
    }) ;
  }
  bool isDark = false ;
 void changeAppMode({mode}){
   if(mode != null)
      {
        isDark = mode ;
        CacheHelper.saveData(key: "isDark", value: isDark).then((value) {
          emit(NewsAppChangeModeState()) ;
        }) ;

      }
   else{
     isDark = !isDark ;
     CacheHelper.saveData(key: "isDark", value: isDark).then((value) {
       emit(NewsAppChangeModeState()) ;
     }) ;

   }
 }

}