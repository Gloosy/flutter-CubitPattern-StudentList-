import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive_animation/cubit/get/cubit_cubit.dart';
import 'package:rive_animation/cubit/post/cubit_post_cubit.dart';
import 'package:rive_animation/cubit/update/update_cubit.dart';
import 'package:rive_animation/data/repository/getrepository.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/search_bar.dart';
import 'package:rive_animation/presentation/screens/entryPoint/entry_point.dart';
import 'package:rive_animation/presentation/screens/home/home_screen.dart';
import 'package:rive_animation/data/service/networkservice.dart';
import 'package:rive_animation/presentation/testscreens/cubit_post_screen.dart';
import 'package:rive_animation/presentation/testscreens/cubit_update_screen.dart';


void main() {
  runApp(
    MyApp(
      apiRepository: ApiRepository(apiService: DioService()),
    ));
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key, required ApiService apiService});

  //final AppRouter? router;

  const MyApp({Key? key, required this.apiRepository}) : super(key: key);

  final ApiRepository apiRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create  : (BuildContext context) =>
          UpdateCubit(apiRepository: ApiRepository(apiService: DioService())),
      child   : MaterialApp(
        home  : UpdateScreen(),
        theme : ThemeData(
          scaffoldBackgroundColor: Color(0xFFEEF1F8),
          primarySwatch: Colors.blue,
          fontFamily: "Intel",
          inputDecorationTheme: InputDecorationTheme(
            filled          : true,
            fillColor       : Colors.white,
            errorStyle      : TextStyle(height: 0),
            border          : defaultInputBorder,
            enabledBorder   : defaultInputBorder,
            focusedBorder   : defaultInputBorder,
            errorBorder     : defaultInputBorder,
          ),
        ),
      ),
    );
    /*
    return MaterialApp(
        title: 'The Flutter Way',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFEEF1F8),
          primarySwatch: Colors.blue,
          fontFamily: "Intel",
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            errorStyle: TextStyle(height: 0),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
          ),
        ),
        home: BlocProvider(
          create: (BuildContext context) =>
              StudentCubit(apiRepository: apiRepository),
          child: EntryPoint(),
        ));
        */
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius   : BorderRadius.all(Radius.circular(16)),
  borderSide     : BorderSide(
    color        : Color(0xFFDEE3F2),
    width        : 1,
  ),
);
