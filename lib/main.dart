import 'package:flutter/material.dart';

import 'appstate.dart';
import 'main_page.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Installed Kernels',
        theme: ThemeData(
          /*
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),*/
          colorSchemeSeed: Colors
              .green, //          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          brightness: Brightness.dark,
          //useMaterial3: true,
        ),
        home: const MyMainPage(),
      ),
    );
    /*return MaterialApp(
      title: 'MyKernels',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: MainPage(),
    );*/
  }
}
