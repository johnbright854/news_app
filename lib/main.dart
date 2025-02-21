import 'dart:io' show Directory;
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:project_1/screens/home_page.dart';
import 'package:project_1/state_management/provider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  runApp(ChangeNotifierProvider(
      create: (context)=> NewsProvider(),
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}


