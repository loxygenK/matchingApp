import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matching_app/user_status.dart';

class SendDataView extends StatefulWidget{
  @override
  _SendData createState() => _SendData();
}

class _SendData extends State<SendDataView> {
  var tags = [];
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
          ),
          Text("タグ"),
          Container(child:tagList(context))

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
              if(tags.length == 0){
                tags.add("タグなし");
              }
              _mainCollection.add({
                'room': roomController.text,
                'details': detailController.text,
                'user': nameController.text,
                'tags': tags
              }
              );
              UserRoomStatus.markAsCreatedRoom(roomController.text);
              tags = [];
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
  Widget tagList(BuildContext context){
    return StreamBuilder(
      stream: Firestore.instance.collection('tags').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError){
          return Text("Error ${snapshot.error}");
        }
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            return Text("loading");
          default:
            return new ListView(
                shrinkWrap: true,
              children: snapshot.data.documents.map((
                  DocumentSnapshot document) {

                  return ListView.builder(
                    shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i){
                    return GestureDetector(
                    child: Card(child:Text(document['tagList'][i],
                    )),
                    onTap: (){
                      bool on = true;
                      print(document['tagList']);
                      try {
                        for (String tag in tags) {
                          if (document['tagList'][i] == tag) {
                            on = false;
                            break;
                          }
                        }
                        if(on) {
                          tags.add(document['tagList'][i]);
                        }
                      }on NoSuchMethodError catch(e){
                        if(on) {
                          tags.add(document['tagList'][i]);
                        }
                        print(e);
                      }
                    },
                    );
                  },
                  itemCount: document['tagList'].length,
                );
              }).toList(),


            );
        }
    },
    );
  }
}