import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/cubit/states.dart';
import 'package:newsapp/network/cachehelper.dart';
import 'package:newsapp/network/diohelper.dart';
import 'package:newsapp/screens/search.dart';

import 'cubit/blocobserver.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized() ;
  DioHelper.init();
 await CacheHelper.init() ;
 bool isDark = CacheHelper.getData(key: "isDark") ;
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(mode: isDark,));
}

class MyApp extends StatelessWidget {
  final mode ;
  const MyApp({this.mode}) ;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsAppCubit()..getBusinessData()..getScienceData()..getSportsData()..changeAppMode(mode: mode)) ,
      ],
      child: BlocConsumer<NewsAppCubit , NewsAppStates>(
        listener: (context , state ){},
        builder: (context ,state ){
          return MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white ,
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.red ,
                      statusBarIconBrightness: Brightness.light ,
                    ),
                    backwardsCompatibility: false ,
                    // should be false to can change status properties
                    backgroundColor: Colors.white ,
                    elevation: 0.0 ,
                    titleTextStyle: TextStyle(
                        color: Colors.red ,
                        fontWeight: FontWeight.bold ,
                        fontSize: 22 ,
                        letterSpacing: 2.0
                    )
                ) ,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed ,
                  backgroundColor: Colors.grey[200] ,
                  selectedItemColor: Colors.orange ,
                )
            ),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: Colors.grey ,
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black ,
                      statusBarIconBrightness: Brightness.light ,
                    ),
                    backwardsCompatibility: false ,
                    // should be false to can change status properties
                    backgroundColor: Colors.grey ,
                    elevation: 0.0 ,
                    titleTextStyle: TextStyle(
                        color: Colors.black ,
                        fontWeight: FontWeight.bold ,
                        fontSize: 22 ,
                        letterSpacing: 2.0
                    )
                ) ,
                iconTheme: IconThemeData(
                  color: Colors.white ,
                  size: 25 ,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed ,
                  backgroundColor: Colors.black38,
                  selectedItemColor: Colors.orange ,
                )
            ),
            themeMode: NewsAppCubit.get(context).isDark? ThemeMode.light :ThemeMode.dark,
            home:Home() ,
            debugShowCheckedModeBanner: false,
          ) ;
        },
      ),
    );
  }
}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News App"),
       actions: [
         Padding(
             padding: EdgeInsets.only(right: 20),
             child:
             IconButton(icon: Icon(Icons.search , color:  Colors.black, size: 25,), onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen())) ;
             }  )
         ) ,
         IconButton(icon: Icon(Icons.brightness_4 , color:  Colors.black, size: 25,), onPressed: (){
           NewsAppCubit.get(context).changeAppMode() ;
         })
       ],
      ),
      body: NewsAppCubit.get(context).screens[NewsAppCubit.get(context).currentIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:NewsAppCubit.get(context).currentIndex,
        onTap: (index){
           NewsAppCubit.get(context).changeNavBar(index) ;
        },
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.business) , label: "business"  ) ,
          BottomNavigationBarItem(icon:Icon(Icons.sports) , label: "sport"  ) ,
          BottomNavigationBarItem(icon:Icon(Icons.science_sharp) , label: "science"  ) ,
        ],
      ),
    );
  }
}

