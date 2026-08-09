const _passage = 'ITWASABRIGHTCOLDDAYINAPRILANDTHECLOCKSWERESTRIKINGTHIRTEEN';

class RunningKeyKey {
  final String stream;

  RunningKeyKey(this.stream);

  String keyCharAt(int position) => stream[position % stream.length];

  factory RunningKeyKey.defaultKey() => RunningKeyKey(_passage);
}
