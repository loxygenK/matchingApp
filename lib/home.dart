import 'package:flutter/material.dart';
import 'package:matching_app/room_grid.dart';
import 'package:matching_app/send.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("マッチングアプリ(仮)")
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              child: RoomGrid()
            )
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => SendDataView())
            );
          }
      )
    );
  }
}