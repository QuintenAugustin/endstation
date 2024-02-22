import 'package:flutter/material.dart';
import 'package:endstation/pages/home_page.dart';

// Definiere die Karte
/*
class Card {
  String suit;
  int rank; // Rank ist nun ein Integer
  String imagePath;

  Card({required this.suit, required this.rank, required this.imagePath});

  @override
  String toString() {
    return 'Suit: $suit, Rank: $rank, ImagePath: $imagePath';
  }

  String get uniqueKey => '$suit$rank';
}
*/
// Erstelle ein Kartendeck

/*List<Card> createDeck() {
  List<String> suits = ['hearts', 'diamonds', 'clubs', 'spades'];
  List<int> ranks = List.generate(
      13, (index) => index + 2); // Generiere Ränge von 2 bis 14 (Ace)
  List<Card> deck = [];

  for (var suit in suits) {
    for (var rank in ranks) {
      String imagePath = '/${suit}${rank}';
      deck.add(Card(suit: suit, rank: rank, imagePath: imagePath));
    }
  }

  return deck;
}
*/
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Titel, Theme und Dark Theme definieren
      title: 'Flutter Demo',
      theme: ThemeData(
        // Definiere ein helles Theme
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        // Definiere ein dunkles Theme
        brightness: Brightness.dark,
      ),
      // Automatischer Wechsel zwischen hellem und dunklem Theme
      themeMode:
          ThemeMode.system, // Benutzt Systemeinstellungen für den Theme-Modus
      home: HomePage(),
    );
  }
}
/*
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
*/
/*
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int spielerzahl = 4; // Startwert

  @override
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
*/
/*
class GamePage extends StatefulWidget {
  final int spielerzahl;

  GamePage({required this.spielerzahl});

  @override
  _GamePageState createState() => _GamePageState();
}
*/
/*
class _GamePageState extends State<GamePage> {
  List<Card> deck = [];
  List<Card> hand = [];
  Random random = Random();
  List<bool?> playerGuesses = [];
  Card? selectedCard;

  @override
  void initState() {
    super.initState();
    deck = createDeck();
    drawCards();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askPlayerGuess();
    });
  }

  void drawCards() {
    Set<String> drawnCards = Set();
    while (hand.length < 2) {
      Card card = deck[random.nextInt(deck.length)];
      if (!drawnCards.contains(card.uniqueKey)) {
        drawnCards.add(card.uniqueKey);
        hand.add(card);
      }
    }
    selectedCard = hand[random.nextInt(
        hand.length)]; // Wähle zufällig eine Karte aus den gezogenen Karten
    print('Gezogene Karten:');
    for (var card in hand) {
      print(card.toString());
    }
  }

  void askPlayerGuess() {
    if (playerGuesses.length < widget.spielerzahl) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Spieler ${playerGuesses.length + 1}, ist die Karte rot oder schwarz?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  playerGuesses.add(true); // Rot
                  Navigator.of(context).pop();
                  askPlayerGuess();
                },
                child: Text('Rot'),
              ),
              TextButton(
                onPressed: () {
                  playerGuesses.add(false); // Schwarz
                  Navigator.of(context).pop();
                  askPlayerGuess();
                },
                child: Text('Schwarz'),
              ),
            ],
          );
        },
      );
    } else {
      revealCardAndShowResults();
    }
  }

  void revealCardAndShowResults() {
    // Bestimme die Farbe der ausgewählten Karte
    bool isCardRed =
        selectedCard!.suit == 'hearts' || selectedCard!.suit == 'diamonds';
    List<bool> results =
        playerGuesses.map((guess) => guess == isCardRed).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ergebnisse'),
          content: SingleChildScrollView(
            child: ListBody(
              children: results.asMap().entries.map((entry) {
                int idx = entry.key;
                bool result = entry.value;
                return Text(
                    'Spieler ${idx + 1}: ${result ? "Richtig" : "Falsch"}');
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
        title: Text('Spiel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Die Karte ist verdeckt. Rate die Farbe!'),
            SizedBox(height: 30), // Erhöhter Platz zwischen den Buttons
          ],
        ),
      ),
    );
  }
}
*/