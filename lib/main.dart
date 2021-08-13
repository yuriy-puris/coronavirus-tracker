import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/screens/dashboard.dart';

import 'package:quizz/services/api.dart';
import 'package:quizz/services/api_service.dart';
import 'package:quizz/repositories/data_repository.dart';
import 'package:quizz/services/data_cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('en', null);
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (_) => DataRepository(
          apiService: APIService(API.sandbox()),
          dataCacheService: DataCacheService(
            sharedPreferences: sharedPreferences
          )
        ),
        child: MaterialApp(
          title: 'Coronovirus tracker',
          theme: ThemeData.dark(),
          home: Dashboard(),
        ));
  }
}
