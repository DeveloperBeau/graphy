/// Fixed plaintext corpus the cbc suite round-trips and hashes.
List<String> cbcSamples() => [
  'THE ARCHIVE KEY IS UNDER THE FOURTH STONE',
  'SILVER BIRDS CARRY WORDS ACROSS THE SEA',
  'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',
];

int cbcSampleCount() => cbcSamples().length;
