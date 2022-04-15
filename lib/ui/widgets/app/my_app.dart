
import 'package:flutter/material.dart';
import 'package:todolist060/ui/navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      // initialRoute: '/groups/form,
      // initialRoute: 'example',
      theme: ThemeData(
        primarySwatch: Colors.blue, 

      ),
    );
  }
}   