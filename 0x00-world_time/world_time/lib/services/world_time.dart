import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; //location name for UI
  late String time; //time @ location
  String flag; //url to asset flag icon
  String url; //stub for location eg. Africa/Nairobi
  late bool isDaytime; // true->day, false->night

  WorldTime({
    required this.location,
    required this.flag,
    required this.url
  });

  Future<void> getTime() async {
    var uri = Uri.http("www.worldtimeapi.org", "/api/timezone/$url", {'q': '{http}'});
    try{
      Response response = await get(uri);
      if(response.statusCode==200) {
        Map data = jsonDecode(response.body);
        String datetime = data['datetime'];
        String offset = data['utc_offset'].substring(1, 3);

        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset)));
        time = DateFormat.jm().format(now);

        isDaytime== now.hour>=6 && now.hour<18 ? true : false ;
      } else {
        time = "could not get time data";
      }
    } catch (e){
      throw "Request failed with error: $e";
    }
  }
}