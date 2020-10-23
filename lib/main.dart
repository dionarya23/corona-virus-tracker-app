import 'package:coronavirus_app/app/repositories/data_repository.dart';
import 'package:coronavirus_app/app/services/api_service.dart';
import 'package:coronavirus_app/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/services/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox())
      ),
    child : MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coronavirus Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF101010),
        cardColor: Color(0xff222222)
      ),
      home: Dashboard()
    )
    );
  }
}
