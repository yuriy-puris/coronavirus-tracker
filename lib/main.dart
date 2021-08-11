import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quizz/services/api.dart';
import 'package:quizz/services/api_service.dart';
import 'package:quizz/repositories/data_repository.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox())
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(title: 'Title'),
      ));
  }
}

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);

  @override
  __HomePageState createState() => __HomePageState();
}

class __HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold();
  }
}