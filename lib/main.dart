import 'package:flutter/material.dart';
import 'package:matching_app/receiveGrid.dart';
import 'send.dart';
import 'data_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "マッチングアプリ(仮)",
        home: HomeView(),
    );
  }
}
class HomeView extends StatelessWidget{
  final dataJudge = DataManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("マッチングアプリ(仮)"),
      ),
      body: BaseView(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return SendDataView();
            }
        ));
      },

      ),
    );
  }
}
class BaseView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            child: Grid(),
          ),
        ),
      ],
    );
  }
}

class Grid extends StatefulWidget{
  @override
  _Grid createState() => new _Grid();
}

class _Grid extends State<Grid> {
  List list;
  List listList;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    i = 0;
    return ReceiveGrid();
  }
}
