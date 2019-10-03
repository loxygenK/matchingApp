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
class BaseView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            child: Grid(),
          ),
        )
      ],
    );
  }
}

class Grid extends StatefulWidget{
  @override
  _Grid createState() => new _Grid();
}

class _Grid extends State<Grid> {
  final list = [0, 1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 3,
      children: List.generate(list.length, (i){
        return GestureDetector(
          child: Card(
            child:Padding(
              padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Text("ルーム名:  $i"),
              ),
                Container(
                  child: Divider()
                ),
                Container(
                  child: Text("詳細"),
                )
            ],
          ))),
          onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return TestView();
                }
              ));
          },
        );
      }),
    );
  }
}
class TestView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("詳細"),
      ),
      body: Text("テスト")
    );
  }
}