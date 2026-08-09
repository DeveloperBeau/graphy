/// Fixed plaintext corpus the adler32 suite round-trips and hashes.
List<String> adler32Samples() => [
  'HOW VEXINGLY QUICK DAFT ZEBRAS JUMP',
  'BRIGHT VIXENS JUMP DOZY FOWL QUACK',
  'JACKDAWS LOVE MY BIG SPHINX OF QUARTZ',
];

int adler32SampleCount() => adler32Samples().length;
