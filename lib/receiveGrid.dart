import 'showDetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiveGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('datas').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error  ${snapshot.error}");
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text("loading");
            default:
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                children: snapshot.data.documents.map((
                    DocumentSnapshot document) {
                  return GestureDetector(
                    child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ListView(
                              children: <Widget>[
                                Container(
                                  child: Text("ルーム名:  ${document['room']}"),
                                ),
                                Container(
                                    child: Divider()
                                ),
                                Container(
                                  child: Text("詳細"),
                                ),
                                Container(
                                  child: Text("${document['details']}"),
                                  decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 1.0),
                                        left: BorderSide(width: 1.0),
                                        right: BorderSide(width: 1.0),
                                        bottom: BorderSide(width: 1.0),
                                      )
                                  ),
                                ),
                                Container(
                                    child: Divider()
                                ),
                                Container(
                                  child: Text('タグ'),
                                ),
                                Container(
                                    child: lists(document)
                                ),
                              ]
                            //lists(document)
                          ),

                        )
                    )
                    ,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return TestView();
                          }
                      ));
                    },
                  );
                }).toList(),
              );
          }
        });
  }

  Widget lists(DocumentSnapshot document) {
    if (document['tags'] == null) {
      return Text("タグが指定されていません");
    }
    switch (document['tags'].length) {
      case 1:
        return Card(child: Text(document['tags'][0]));
        break;
      case 2:
        return Card(child: Row(
          children: <Widget>[
            Text(document['tags'][0]),
            Text(document['tags'][1]),
          ],
        ),);
        break;
      case 3:
        return Card(child: Row(
          children: <Widget>[
            Text(document['tags'][0]),
            Text(document['tags'][1]),
            Text(document['tags'][2])
          ],
        ),);
        break;
      default:
        return Card(child: Row(
          children: <Widget>[
            Text(document['tags'][0]),
            Text(document['tags'][1]),
            Text("+" + (document['tags'].length - 2).toString())
          ],
        ),);
        break;
    }
  }
}