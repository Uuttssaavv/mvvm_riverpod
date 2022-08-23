import 'package:flutter/material.dart';
import 'package:flutter_project/core/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: Routes.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
