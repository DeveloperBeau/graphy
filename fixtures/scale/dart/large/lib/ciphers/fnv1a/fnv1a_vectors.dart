/// Fixed plaintext corpus the fnv1a suite round-trips and hashes.
List<String> fnv1aSamples() => [
  'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',
  'PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS',
  'SPHINX OF BLACK QUARTZ JUDGE MY VOW',
];

int fnv1aSampleCount() => fnv1aSamples().length;
