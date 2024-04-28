import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:world_time/dump/locations.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> places = locations;

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    Navigator.pop(context, {
      "location": instance.location,
      "time": instance.time,
      "flag": instance.flag,
      "isDaytime": instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[950],
        title: const Text("choose location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: (){updateTime(index);},
                title: Text(
                  places[index].location,
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/${places[index].flag}"),
                ),
              ),
            ),
          );
        },
        itemCount: places.length,
      ),
    );
  }
}
