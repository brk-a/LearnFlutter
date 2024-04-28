import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/loading.dart';

// @override
void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
        "/": (context) => const Loading(),
        "/home": (context) => const Home(),
        "/location": (context) => const ChooseLocation(),
    },
  ));
}

// class Home extends StatelessWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("World time"),
//         backgroundColor: Colors.lightBlue[600],
//         centerTitle: true,
//       ),
//       body: ,
//     );
//   }
// }