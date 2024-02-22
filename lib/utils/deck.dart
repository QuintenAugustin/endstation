import '../models/card.dart';

List<Card> createDeck() {
  //Here we generate the Deck itself. Each Suit has 13 Cards total and we start with 2
  List<String> suits = ['hearts', 'diamonds', 'clubs', 'spades'];
  List<int> ranks = List.generate(13, (index) => index + 2);
  List<Card> deck = [];
//Here we use card.dart to create new cards in a nested for loop. For each suit
//and for each rank a card is created. Furthermore we dynamically create the path
//to the images for the cards here and hope to call them that way (later) from suit and rank
//all of this info is then stored in our deck list.
  for (var suit in suits) {
    for (var rank in ranks) {
      String imagePath = '/${suit}${rank}';
      deck.add(Card(suit: suit, rank: rank, imagePath: imagePath));
    }
  }
//Deck is our list/array of cards (kinda obvious I guess)
  return deck;
}
