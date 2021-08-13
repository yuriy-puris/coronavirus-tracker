import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizz/screens/dashboard.dart';

import 'package:quizz/services/api.dart';
import 'package:quizz/services/api_service.dart';
import 'package:quizz/repositories/data_repository.dart';

void main() {
  // await initializeDateFormatting('en', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (_) => DataRepository(apiService: APIService(API.sandbox())),
        child: MaterialApp(
          title: 'Coronovirus tracker',
          theme: ThemeData.dark(),
          home: Dashboard(),
        ));
  }
}
