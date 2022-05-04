import 'package:flutter/material.dart';
import 'package:oye_beauty_assignment/dashboard/dashboad_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
            headline2: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
            headline3: TextStyle(color: Colors.black, fontFamily: 'Mulish'),
          ),
          primarySwatch: Colors.blue,
        ),
        home: const DashboardMain());
  }
}
