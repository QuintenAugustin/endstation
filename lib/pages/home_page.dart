import 'package:flutter/material.dart';
import 'game_page.dart';
import 'package:endstation/pages/rules_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// int spielerzahl defines the amount of players in the game with a base of 4
class _HomePageState extends State<HomePage> {
  int spielerzahl = 4; // Startwert

  @override
  //This stuff is Frontend related randomness. I should split the player count off from here. Later.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startseite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (spielerzahl > 1) spielerzahl--;
                    });
                  },
                ),
                Text(
                  spielerzahl.toString(),
                  style: TextStyle(fontSize: 24.0),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      if (spielerzahl < 10) spielerzahl++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10), // Fügt Platz unter dem Spieler-Counter hinzu
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50), // Steuert die Breite der Buttons
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GamePage(spielerzahl: spielerzahl)),
                  );
                },
                child: Text('Spielen'),
              ),
            ),
            SizedBox(height: 10), // Abstand zwischen den Buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 100), // Steuert die Breite der Buttons
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RulesPage()),
                  );
                },
                child: Text('Spielregeln'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
