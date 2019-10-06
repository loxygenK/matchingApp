import 'package:flutter/material.dart';

class TestView extends StatelessWidget {

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

  List<Container> createTagsWidget(List<String> tagnames) {
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

    return tags;
  }

  Widget build(BuildContext context) {
    // TODO: Get the room's information from cloud server
    String room_name = "ルームのお名前";
    String inviter_name = "募集している人の名前";
    String details = "スクロールができる詳細画面。";
    List<String> tags = ["スクロール", "が", "できる", "お気に入り", "の", "タグ", "一覧"];

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
                            child: Row(children: createTagsWidget(tags)
                            )
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
