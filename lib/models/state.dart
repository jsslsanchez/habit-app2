import 'package:flutter/material.dart';
import 'package:habitos_app/widgets/title.dart';

class HabitCalendarPage extends StatefulWidget {
  const HabitCalendarPage({super.key});

  @override
  _HabitCalendarPageState createState() => _HabitCalendarPageState();
}

class _HabitCalendarPageState extends State<HabitCalendarPage> {
  final List<Widget> habitList = [];

  void _addHabit(bool isChecked) {
    setState(() {
      // Agregar el nuevo cuadro
      habitList.add(_buildHabitItem(isChecked));

      // Si se selecciona "X", vacía la lista después de mostrar el nuevo cuadro
      if (!isChecked) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            habitList.clear(); // Vacía completamente la lista
          });
        });
      }
    });
  }
