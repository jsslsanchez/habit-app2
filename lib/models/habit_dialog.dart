import 'package:flutter/material.dart';
import 'package:habitos_app/widgets/title.dart';
import 'package:habitos_app/models/state.dart';
import 'package:habitos_app/widgets/habit_item.dart';
import 'package:habitos_app/widgets/item_list.dart';

void _showAddHabitDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      bool isChecked = true; // Estado del checkbox
      return AlertDialog(
        title: const Text('Agregar Hábito'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('¿Completado?'),
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? true;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _addHabit(isChecked);
              Navigator.of(context).pop();
            },
            child: const Text('Agregar'),
          ),
        ],
      );
    },
  );
}
