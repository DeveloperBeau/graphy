/// Fixed plaintext corpus the crc32 suite round-trips and hashes.
List<String> crc32Samples() => [
  'BRIGHT VIXENS JUMP DOZY FOWL QUACK',
  'JACKDAWS LOVE MY BIG SPHINX OF QUARTZ',
  'MEET ME AT THE HARBOUR AT MIDNIGHT',
];

int crc32SampleCount() => crc32Samples().length;
