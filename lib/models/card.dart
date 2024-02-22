class Card {
  String suit;
  int rank; // Rank ist nun ein Integer
  String imagePath;
// This creates the necessarry information for the playing cards.
  Card({required this.suit, required this.rank, required this.imagePath});

  @override
  String toString() {
    return 'Suit: $suit, Rank: $rank, ImagePath: $imagePath';
  }

// Our unique key is a combination of suit and rank. This way we dont get doubled cards.
// It is used to later on also ensure that cards aren't drawn several times. (GOTO gamepage for that.)
  String get uniqueKey => '$suit$rank';
}
