import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TestView extends StatelessWidget {

  DocumentSnapshot _document;

  TestView(this._document);

  Container createInfoView(String label, Widget widget, {bool margin = true}) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border(right: BorderSide(color: Colors.black45))),
                    child: Center(child: Text(label)))),
            Expanded(
                flex: 4,
                child: Container(
                    padding: EdgeInsets.only(left: (margin ? 5 : 0)),
                    child: widget))
          ],
        )
    );
  }

  Widget createTagsWidget(var tagnames) {

    if(tagnames == null){
      return Text("タグが指定されていません");
    }

    List<Container> tags = [];
    for (String tag in tagnames) {
      tags.add(new Container(
          margin: EdgeInsets.only(left: 3, right: 3),
          padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(tag)
        )
      );
    }

    return Row(children: tags);
  }

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

            String room_name = _document["room"];
            String inviter_name = _document["user"];
            String details =_document["details"];
            var tags = _document["tags"];

            return Scaffold(
              appBar: AppBar(title: Text("ルーム詳細")),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    createInfoView("ルーム名", Text(room_name)),
                    createInfoView("募集者名", Text(inviter_name)),
                    createInfoView(
                      "タグ",
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: createTagsWidget(tags)
                      ),
                      margin: false),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(3)
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Text(details)
                          )
                        )
                      )
                    ),
                  ]
                )
              )
            );
        }
      }
    );
  }
}
