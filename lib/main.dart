import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tut/providers/importanttodoprovider.dart';
import 'package:provider_tut/providers/todoprovider.dart';
import 'package:provider_tut/views/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => ImportantTodoProvider())
      ],
      child: MaterialApp(
          title: 'Provider Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen()),
    );
  }
}
