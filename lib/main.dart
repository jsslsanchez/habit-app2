import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendario de Hábitos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const HabitCalendarPage(),
    );
  }
}

class HabitCalendarPage extends StatefulWidget {
  const HabitCalendarPage({super.key});

  @override
  _HabitCalendarPageState createState() => _HabitCalendarPageState();
}

class _HabitCalendarPageState extends State<HabitCalendarPage> {
  final List<Widget> habitList = [];
  int dayCount = 1; // Contador de días
  bool habitCompleted =
      false; // Bandera para indicar si el hábito fue completado

  void _addHabit(bool isChecked) {
    // Asegurarnos de cerrar el diálogo de agregar tarea
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(); // Cierra el diálogo de agregar tarea
    }

    setState(() {
      // Si el hábito fue completado, vaciar la lista y reiniciar el contador
      if (habitCompleted) {
        habitList.clear();
        dayCount = 1;
        habitCompleted = false; // Resetear la bandera
      }

      // Verificar si ya existe un cuadro con "X" en la lista
      bool hasX = habitList.any((widget) {
        if (widget is Padding) {
          final container = widget.child as Container;
          final color = (container.decoration as BoxDecoration).color;
          return color == Colors.red[400]; // Detectar color rojo
        }
        return false;
      });

      if (hasX) {
        habitList.clear(); // Vaciar la lista si hay una "X"
        dayCount = 1; // Reiniciar el contador
      }

      // Agregar el nuevo cuadro
      habitList.add(_buildHabitItem(isChecked));

      // Verificar si es el día 21 y tiene check
      if (dayCount == 21 && isChecked) {
        Future.delayed(const Duration(milliseconds: 200), () {
          _showCompletionDialog(); // Mostrar aviso de "Hábito completado"
        });
        habitCompleted = true; // Activar la bandera de hábito completado
      } else {
        dayCount++; // Incrementar el contador
      }
    });
  }

  Widget _buildHabitItem(bool isChecked) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
          color: isChecked ? Colors.green[200] : Colors.red[400],
        ),
        child: Center(
          child: Text(
            isChecked
                ? '✔️ Tarea Completada día $dayCount'
                : '❌ Tarea No Completada día $dayCount',
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFEB75A1),
          title: const Text(
            '¡Felicidades!',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            '¡Hábito completado después de 21 días!',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB75A1), // Color del AppBar
        centerTitle: true, // Centrar el texto
        title: const Text(
          'Calendario de Hábitos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color(0xFFEB938D), // Fondo de la página principal
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => habitList[index],
                childCount: habitList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isChecked = true; // Estado inicial del Checkbox
        return AlertDialog(
          backgroundColor:
              const Color(0xFFEB75A1), // Color del cuadro de diálogo
          title: const Text(
            'Agregar Día',
            style: TextStyle(color: Colors.white),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '¿Completado?',
                    style: TextStyle(color: Colors.white),
                  ),
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.pink,
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
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                _addHabit(isChecked); // Llamar a la función para agregar tarea
              },
              child: const Text(
                'Agregar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
