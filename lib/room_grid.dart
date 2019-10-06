import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matching_app/info_display.dart';

class RoomGrid extends StatefulWidget {

  final Color _borderColor = Color(0xabababff);

  @override
  _RoomGrid createState() => _RoomGrid();

  Color get borderColor => _borderColor;
}

class _RoomGrid extends State<RoomGrid> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("datas").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        if (snapshot.connectionState == ConnectionState.waiting) return Text("loading");
        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          children: snapshot.data.documents.map(
              (DocumentSnapshot document) => createGridContent(document)
          ).toList()
        );
      }
    );
  }

  GestureDetector createGridContent(DocumentSnapshot document) {
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
                      child: Divider(color: widget.borderColor)
                  ),
                  Container(
                    child: Text("オーナー: ${document['user']}"),
                  ),
                  Container(
                    child: Divider(color: widget.borderColor),
                  ),
                  Container(
                    child: Text("ひとこと"),
                  ),
                  Container(
                    child: Text("${document['intro']}"),
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: widget.borderColor),
                          left: BorderSide(width: 1.0, color: widget.borderColor),
                          right: BorderSide(width: 1.0, color: widget.borderColor),
                          bottom: BorderSide(width: 1.0, color: widget.borderColor),
                        )
                    ),
                  ),
                  Container(
                      child: Divider(color: widget.borderColor)
                  ),
                  Container(
                    child: Text('タグ'),
                  ),
                  Container(
                      child: lists(document)
                  ),
                ]
            )
          )
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InfoDisplay())
        );
      }
    );
  }

  // TODO: メソッド名なんとかしろ
  Widget lists(DocumentSnapshot document) {
    if (document['tags'] == null) {
      return Text("タグが指定されていません");
    }
    var tagList = <Widget>[];
    var tags = document["tags"] as List;
    tags.forEach((tag) => tagList.add(Text(tag)));
    if (tags.length >= 4) {
      return Card(
        child: Row(
          children: <Widget>[
            tagList[0],
            tagList[1],
            Text("+" + (tags.length - 2).toString())
          ]
        )
      );
    }
    return Card(
      child: Row(
        children: tagList
      )
    );
  }
}