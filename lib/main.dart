import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oye_beauty_assignment/screens/dashboard/dashboad_main.dart';
import 'package:oye_beauty_assignment/screens/select_date_time.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            headline4: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
          ),
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: route,
        home: const DashboardMain());
  }

  Route route(RouteSettings settings) {
    switch (settings.name) {
      case '/selectDataTime':
        return PageTransition(
            child: SelectDateTime(), type: PageTransitionType.leftToRight);
      default:
        return PageTransition(
            child: DashboardMain(), type: PageTransitionType.leftToRight);
    }
  }
}
