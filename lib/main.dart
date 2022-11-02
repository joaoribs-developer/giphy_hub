import 'package:flutter/material.dart';
import 'package:giphy_hub/ui/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GIPHY HUB',
      theme: ThemeData(
        hintColor: Colors.blueGrey,
      primaryColor: Colors.black
      ),
      home: const MyHomePage(),
    );
  }

}




