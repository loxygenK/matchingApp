import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'delete.dart';
class DeleteButton extends StatelessWidget{
  final dataManager = DataManager();
  @override
  Widget build(BuildContext context) {
    var judge = dataManager.judgeRoom();
    judge.then((judge){
      if(judge){
        return RaisedButton(
          child: Text("ルームを消す"),
          onPressed: (){
            dataManager.deleteRoom();
          },
        );
      }
      else{
        return Container();
      }
    });
  }
}
class DataManager{
  final deleter = RoomDeleter();
  void createRoom(String roomName)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('roomName', roomName);
    await pref.setBool('savedData', true);
  }
  void deleteRoom()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var roomName = pref.get("roomName");
    deleter.search(roomName);
    await pref.setString('roomName', null);
    await pref.setBool('savedData', false);
  }
  Future<bool> judgeRoom()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool judge = pref.get('savedData');
    return judge;
  }
}