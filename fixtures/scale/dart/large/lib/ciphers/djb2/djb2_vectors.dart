/// Fixed plaintext corpus the djb2 suite round-trips and hashes.
List<String> djb2Samples() => [
  'PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS',
  'SPHINX OF BLACK QUARTZ JUDGE MY VOW',
  'HOW VEXINGLY QUICK DAFT ZEBRAS JUMP',
];

int djb2SampleCount() => djb2Samples().length;
