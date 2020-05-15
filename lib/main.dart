import 'package:flutter/material.dart';
import 'package:soundeffectivedlsample/screens/home_screen.dart';

const int IS_NOT_LOADED = -1;

List<int> soundIds;

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

