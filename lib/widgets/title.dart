import 'package:flutter/material.dart';
import 'package:habitos_app/models/state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendario de Hábitos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HabitCalendarPage(),
    );
  }
}
