import 'dart:math';

class Card {
  String suit;
  int rank; // Rank ist nun ein Integer
  String imagePath;

  Card({required this.suit, required this.rank, required this.imagePath});

  @override
  String toString() {
    return 'Suit: $suit, Rank: $rank, ImagePath: $imagePath';
  }

  // Generiere einen eindeutigen Schlüssel für jede Karte
  String get uniqueKey => '$suit$rank';
}

List<Card> createDeck() {
  List<String> suits = ['hearts', 'diamonds', 'clubs', 'spades'];
  List<int> ranks = List.generate(
      13, (index) => index + 2); // Generiere Ränge von 2 bis 14 (Ace)
  List<Card> deck = [];

  for (var suit in suits) {
    for (var rank in ranks) {
      String imagePath = '/$suit$rank';
      deck.add(Card(suit: suit, rank: rank, imagePath: imagePath));
    }
  }

  return deck;
}

void main() {
  // Define the suits, colors, and numbers
  /*
  List<String> suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades'];
  List<String> colors = ['Red', 'Red', 'Black', 'Black'];
  List<int> numbers = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  // Create the DataFrame
  List<Map<String, dynamic>> deck = [];

  // Populate the DataFrame with all possible cards
  for (String suit in suits) {
    for (int i = 0; i < numbers.length; i++) {
      deck.add({
        'Card': '${numbers[i]} of $suit',
        'Color': colors[
            i < 2 ? 0 : 2], // First two suits are red, last two are black
        'Number': numbers[i]
      });
    }
  }

  // Print the DataFrame
  for (var card in deck) {
    print(card);
  }
*/

  List<Card> deck = createDeck();
  Random random = Random();
  Set<String> drawnCards =
      {}; // Verwendet ein Set, um gezogene Karten zu speichern
  List<Card> hand = []; // Eine Liste, um die gezogenen Karten zu speichern

  // Ziehe 5 einzigartige Karten
  while (hand.length < 4) {
    Card card = deck[random.nextInt(deck.length)];
    if (!drawnCards.contains(card.uniqueKey)) {
      drawnCards.add(card.uniqueKey);
      hand.add(card);
    }
  }

  // Zeige die gezogenen Karten
  print('Gezogene Karten:');
  for (var card in hand) {
    print(card.toString());
  }
}
