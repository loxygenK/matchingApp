import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List list;
  List listList;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    i = 0;
    return StreamBuilder(
      stream: Firestore.instance.collection('datas').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError){
          return Text("Error  ${snapshot.error}");
        }
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Text("loading");
          default:
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              children: snapshot.data.documents.map((DocumentSnapshot document){
                return GestureDetector(
                  child: Card(
                    child:Padding(
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
                          child: lists()
                        )
                      ]
                        //lists(document)
                  ),

                    )
                    )
                  ,
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return TestView();
                        }
                      ));
          },
        );
      }).toList(),
        );}
    });
  }

  Widget lists(){
    Firestore.instance.collection('datas').snapshots().listen((data){
      list = data.documents.toList()[i].data['tags'].toList();
      print(list);
    });
    i++;
    switch (list.length){
      case 0:
        return Text("タグが指定されていません");
        break;
      case 1:
        return Card(child: Text(list[0]));
        break;
      case 2:
        return Card(child: Row(
          children: <Widget>[
            Text(list[0]),
            Text(list[1]),
          ],
        ),);
        break;
      case 3:
        return Card(child: Row(
          children: <Widget>[
            Text(list[0]),
            Text(list[1]),
            Text(list[2])
          ],
        ),);
        break;
      default:
        return Card(child: Row(
          children: <Widget>[
            Text(list[0]),
            Text(list[1]),
            Text("+" +(list.length - 2).toString())
          ],
        ),);
        break;
    }

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
