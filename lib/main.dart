import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "マッチングアプリ(仮)",
      home: Scaffold(
        appBar: AppBar(
          title: Text("マッチングアプリ(仮)"),
        ),
        body: BaseView(),
      )
    );
  }
}
//TODO make BaseVIew with StatelessWidget
