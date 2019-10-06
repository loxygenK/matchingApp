import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendDataView extends StatefulWidget{
  @override
  _SendData createState() => _SendData();
}

class _SendData extends State<SendDataView> {
  final roomController = new TextEditingController();
  final nameController = new TextEditingController();
  final detailController = new TextEditingController();
  final _mainCollection = Firestore.instance.collection("datas");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ルーム作成"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("ルーム名"),
          Expanded(
            child:TextField(
            controller: roomController,
            maxLength: 10,
          ),
          ),
          Text("詳細"),
          Expanded(
            child: TextField(
              maxLength: 20,
              controller: detailController,
            ),
          ),
          Text("ユーザー名"),
          Expanded(
            child: TextField(
              maxLength: 10,
                controller: nameController,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
            if (roomController.text == "" || detailController.text == ""|| nameController.text == ""){
              return showDialog(
                context: context,
                builder: (_){
                  return AlertDialog(
                    title: Text("エラー"),
                    content: Text("必要な情報が記入されていません"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("ok"),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  );
                }
              );
            }
            else {
              _mainCollection.add({
                'room': roomController.text,
                'details': detailController.text,
                'user': nameController.text
              }
              );
            }
            Navigator.pop(context);


    },

    ));
  }

  @override
  void dispose() {
    roomController.dispose();
    nameController.dispose();
    detailController.dispose();
    super.dispose();
  }
}