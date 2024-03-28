import 'package:flutter/material.dart';

class GameLogic {
  static Map<int, int> calculateCorrectGuesses(
      List<bool?> playerGuesses, int spielerzahl) {
    Map<int, int> correctGuesses = {};
    for (int i = 0; i < spielerzahl; i++) {
      correctGuesses[i + 1] =
          playerGuesses.where((guess) => guess == true).length;
    }
    return correctGuesses;
  }

  static void showRoundTwoResults(
      BuildContext context, Map<int, int> correctGuesses) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Round Two Results'),
          content: SingleChildScrollView(
            child: ListBody(
              children: correctGuesses.entries.map((entry) {
                int playerNumber = entry.key;
                int correctCount = entry.value;
                return Text(
                    'Player $playerNumber: $correctCount correct guesses');
              }).toList(),
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
}
