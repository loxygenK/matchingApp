import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDeleter{
  void search(String room) async{
    Firestore.instance.collection("datas").where('room', isEqualTo: room).snapshots().first.asStream().listen((QuerySnapshot snapshot){
      Firestore.instance.collection("datas").document(snapshot.documents[0].documentID).delete();
    }
    );
  }
}