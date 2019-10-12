
import 'package:shared_preferences/shared_preferences.dart';

class UserRoomStatus{

	static void markAsCreatedRoom(String room_name) async {

		SharedPreferences pref = await SharedPreferences.getInstance();
		await pref.setBool("room_saved", true);
		await pref.setString("room_name", room_name);

	}

	static void markAsDeletedRoom() async {

		SharedPreferences pref = await SharedPreferences.getInstance();
		await pref.setBool("room_saved", false);
		await pref.setString("room_name", "");

	}

	static Future<String> getCreatedRoom() async {

		SharedPreferences pref = await SharedPreferences.getInstance();
		String room_name;

		if(pref.containsKey("room_saved") && pref.getBool("room_saved")){
			room_name = pref.getString("room_name");
		}else return null;
		return room_name;

	}

}