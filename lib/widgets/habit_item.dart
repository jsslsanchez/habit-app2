import 'package:flutter/material.dart';
import 'package:habitos_app/widgets/title.dart';
import 'package:habitos_app/models/state.dart';

Widget _buildHabitItem(bool isChecked) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(15.0),
        color: isChecked ? Colors.green[200] : Colors.red[200],
      ),
      child: Center(
        child: Text(
          isChecked ? '✔️ Tarea Completada' : '❌ Tarea No Completada',
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    ),
  );
}
