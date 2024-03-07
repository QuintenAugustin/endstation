import 'package:flutter/material.dart';
import 'dart:math';
import 'package:endstation/models/card.dart' as models;
import 'package:endstation/utils/deck.dart';
// This file contains lots of logic regarding actually drawing cards and at the bottom we have a little bit of front end.

// Homepage passes the info about the player count to the game page.
class GamePage extends StatefulWidget {
  final int spielerzahl;

  GamePage({required this.spielerzahl});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //Deck of cards
  List<models.Card> deck = [];
  //The drawn cards. We draw all cards needed at the same time and store them here
  List<models.Card> hand = [];
  Random random = Random();
  //This is where we store the guesses made by each player.
  List<bool?> playerGuesses = [];
  //This is our card
  models.Card? selectedCard;
  //Create a list for player scores
  List<int> playerScores = [];

  @override
  void initState() {
    super.initState();
    deck = createDeck();
    drawCards();
    // Initialize playerScores list with 0 for each player
    playerScores = List<int>.generate(widget.spielerzahl, (int index) => 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askPlayerGuess();
    });
  }

  void drawCards() {
    Set<String> drawnCards = Set();
    while (hand.length < 2) {
      //Hand length defines how many cards we draw
      models.Card card = deck[random.nextInt(deck.length)];
      // here we ensure that each card can only be drawn once
      if (!drawnCards.contains(card.uniqueKey)) {
        drawnCards.add(card.uniqueKey);
        hand.add(card);
      }
    }
    selectedCard = hand[random.nextInt(// Random effectively shuffles our cards
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

    // Update player scores based on their guess results
    for (int i = 0; i < results.length; i++) {
      if (results[i]) {
        playerScores[i]++; // Increment score for correct guess
      }
    }

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
                    'Spieler ${idx + 1}: ${result ? "Richtig" : "Falsch"} - Score: ${playerScores[idx]}');
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
