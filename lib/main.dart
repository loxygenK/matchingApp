import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matching_app/delete.dart';
import 'package:matching_app/receiveGrid.dart';
import 'package:matching_app/user_status.dart';
import 'send.dart';
import 'data_manager.dart';

void main(){
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "マッチングアプリ(仮)",
        home: HomeView(),
    );
  }
}
// ignore: must_be_immutable
class HomeView extends StatelessWidget{
  var deleter = RoomDeleter();
  final dataJudge = DataManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("マッチングアプリ(仮)"),
        actions: <Widget>[
          RaisedButton(
            onPressed: (){
              UserRoomStatus.getCreatedRoom().then(
                      (roomName) {
                    if(roomName != null)
                      deleter.search(roomName);
                  }
              );
            },
            child: Text("ルームを消す"),
            color: Colors.blue,
            textColor: Colors.white,
            splashColor: Colors.blue,
          )
        ],
      ),
      body: BaseView(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              UserRoomStatus.getCreatedRoom().then(
                  (roomName){
                    if(roomName == null) print("null");
                  }
              );
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
