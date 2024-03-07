import 'dart:math';
import 'package:flutter/material.dart';
import 'package:endstation/models/card.dart' as models;
import 'package:endstation/utils/deck.dart';
import 'package:endstation/utils/guess_logic.dart';

/*
class GamePageRoundTwo extends StatefulWidget {
  final List<models.Card> hand;

  GamePageRoundTwo({required this.hand});

  @override
  _GamePageRoundTwoState createState() => _GamePageRoundTwoState();
}

class _GamePageRoundTwoState extends State<GamePageRoundTwo> {
  Random random = Random();
  models.Card? selectedCard;

  @override
  void initState() {
    super.initState();
    // Assign the second card in the hand to selectedCard
    selectedCard = widget.hand.length > 1 ? widget.hand[1] : null;
    startSecondRound();
  }

  void startSecondRound() {
    // Implement the logic to initiate the second round
    // For example, display UI elements for guessing and handle user input
  }

  void handleGuess(bool isGreater) {
    // Access the first and second cards in the hand
    models.Card firstCard = widget.hand[0];
    models.Card secondCard = selectedCard!;

    // Compare the value of the second card with the first card
    GuessResult guessResult =
        GuessLogic.compareCardRanks(firstCard, secondCard);

    // Determine whether the guess was correct based on the comparison result
    bool guessCorrect = (isGreater && guessResult == GuessResult.Greater) ||
        (!isGreater && guessResult == GuessResult.Smaller);

    // Display the result to the user and proceed accordingly
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Guess Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(guessCorrect ? 'Correct guess!' : 'Wrong guess!'),
              SizedBox(height: 10),
              Text('First Card Value: ${firstCard.rank}'),
              Text('Second Card Value: ${secondCard.rank}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Continue the game or go to the next round
                // For example, navigate back to the main game page
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Implement the UI for the second round
    // For example, display cards and UI elements for guessing
    return Scaffold(
      appBar: AppBar(
        title: Text('Round Two'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Guess whether the second card has a greater value:'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                handleGuess(true); // Player guesses the value is greater
              },
              child: Text('Greater'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                handleGuess(false); // Player guesses the value is smaller
              },
              child: Text('Smaller'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

class GamePageRoundTwo extends StatefulWidget {
  final List<models.Card> hand;
  final int spielerzahl;

  GamePageRoundTwo({required this.hand, required this.spielerzahl});

  @override
  _GamePageRoundTwoState createState() => _GamePageRoundTwoState();
}

class _GamePageRoundTwoState extends State<GamePageRoundTwo> {
  Random random = Random();
  models.Card? selectedCard;
  List<bool?> playerGuesses = [];

  @override
  void initState() {
    super.initState();
    selectedCard = widget.hand.length > 1 ? widget.hand[1] : null;
    startSecondRound();
  }

  void startSecondRound() {
    //Wild stuff tbh. Not exactly sure why this fixes my player count pass over error but it does so thats cool.
    Future.delayed(Duration.zero, () {
      askPlayerGuess();
    });
  }

// WE STILL HAVE AN UNHANDLED VALUE QUINTEN! You need to handle equal values too. Not too high prio but dont forget bruh.
  void askPlayerGuess() {
    for (int i = 0; i < widget.spielerzahl; i++) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('Player ${i + 1}, is the second card greater or smaller?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  playerGuesses.add(true); // Greater
                  Navigator.of(context).pop();
                  if (playerGuesses.length == widget.spielerzahl) {
                    revealCardAndShowResults();
                  }
                },
                child: Text('Greater'),
              ),
              TextButton(
                onPressed: () {
                  playerGuesses.add(false); // Smaller
                  Navigator.of(context).pop();
                  if (playerGuesses.length == widget.spielerzahl) {
                    revealCardAndShowResults();
                  }
                },
                child: Text('Smaller'),
              ),
            ],
          );
        },
      );
    }
  }

  void revealCardAndShowResults() {
    models.Card firstCard = widget.hand[0];
    models.Card secondCard = selectedCard!;

    // Determine the correct result based on card comparison
    bool isGreater = secondCard.rank > firstCard.rank;

    // Check each player's guess and determine correctness
    List<bool> results =
        playerGuesses.map((guess) => guess == isGreater).toList();

    // Display the result to the user
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Round Two Results'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('First Card: ${firstCard.rank}'),
                Text('Second Card: ${secondCard.rank}'),
                SizedBox(height: 10),
                ...results.asMap().entries.map((entry) {
                  int idx = entry.key;
                  bool result = entry.value;
                  return Text(
                      'Player ${idx + 1}: ${result ? "Correct" : "Wrong"}');
                }).toList(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Implement the UI for the second round
    return Scaffold(
      appBar: AppBar(
        title: Text('Round Two'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Guess whether the second card has a greater value:'),
          ],
        ),
      ),
    );
  }
}
