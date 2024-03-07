import 'package:endstation/models/card.dart';

// Currently not used. Currently directly implemented in game page round two. If used again this needs to get remade.
// It may be more efficient and save code to handle it in an external utility file rather than in the gamepages considering
// that round three also exists and code will be similar to that
enum GuessResult {
  Greater,
  Smaller,
  Equal,
}

class GuessLogic {
  static GuessResult compareCardRanks(Card firstCard, Card secondCard) {
    if (secondCard.rank > firstCard.rank) {
      return GuessResult.Greater;
    } else if (secondCard.rank < firstCard.rank) {
      return GuessResult.Smaller;
    } else {
      return GuessResult.Equal;
    }
  }
}
