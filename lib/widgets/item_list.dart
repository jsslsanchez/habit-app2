import 'package:flutter/material.dart';
import 'package:habitos_app/widgets/title.dart';
import 'package:habitos_app/models/state.dart';
import 'package:habitos_app/widgets/habit_item.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Calendario de Hábitos'),
    ),
    body: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => habitList[index],
            childCount: habitList.length,
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _showAddHabitDialog(),
      child: const Icon(Icons.add),
    ),
  );
}
