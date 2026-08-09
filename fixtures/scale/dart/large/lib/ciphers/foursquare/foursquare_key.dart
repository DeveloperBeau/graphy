import '../playfair/playfair_key.dart';

class FourSquareKey {
  final String upperWord;
  final String lowerWord;

  FourSquareKey(this.upperWord, this.lowerWord);

  String upperSquare() => PlayfairKey(upperWord).square();

  String lowerSquare() => PlayfairKey(lowerWord).square();

  factory FourSquareKey.defaultKey() => FourSquareKey('WINTER', 'SUMMER');
}
