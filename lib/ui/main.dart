import 'package:flutter/material.dart';
import 'package:res_sub01/Routes/Route.dart';
import 'package:res_sub01/ui/SplashScreen.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mal Restaurant',
      debugShowCheckedModeBanner: false,
      routes: route,
      initialRoute: "/",
      home: const SplashScreen(),
    );
  }
}
