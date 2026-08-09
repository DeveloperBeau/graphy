import '../playfair/playfair_key.dart';

class TwoSquareKey {
  final String topWord;
  final String bottomWord;

  TwoSquareKey(this.topWord, this.bottomWord);

  String topSquare() => PlayfairKey(topWord).square();

  String bottomSquare() => PlayfairKey(bottomWord).square();

  factory TwoSquareKey.defaultKey() => TwoSquareKey('EXAMPLE', 'KEYWORD');
}
