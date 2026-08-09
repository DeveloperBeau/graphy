/// Fixed plaintext corpus the ecb suite round-trips and hashes.
List<String> ecbSamples() => [
  'SIGNAL FIRES BURN ALONG THE COAST TONIGHT',
  'THE ARCHIVE KEY IS UNDER THE FOURTH STONE',
  'SILVER BIRDS CARRY WORDS ACROSS THE SEA',
];

int ecbSampleCount() => ecbSamples().length;
