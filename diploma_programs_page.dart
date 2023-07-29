import 'package:flutter/material.dart';

class DiplomaProgramsPage extends StatelessWidget {
  final List<String> programs;

  const DiplomaProgramsPage({Key? key, required this.programs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diploma Programs'),
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return ListTile(
            title: Text(program),
          );
        },
      ),
    );
  }
}
