import 'package:flutter/material.dart';
import 'package:matching_app/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "マッチングアプリ(仮)",
        home: Home()
    );
  }
}