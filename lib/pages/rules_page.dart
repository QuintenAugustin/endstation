import 'package:flutter/material.dart';

//Very basic rules page, nothing to see here yet.
class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spielregeln'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Hier stehen die Spielregeln... \n\n'
          '1. Regel 1 \n\n'
          '2. Regel 2 \n\n'
          '3. Regel 3 \n\n'
          'Füge hier weitere Regeln hinzu.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
