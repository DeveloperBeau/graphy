import '../core/cipher_suite.dart';
import 'classical_registry.dart';
import 'polyalphabetic_registry.dart';
import 'stream_registry.dart';
import 'transposition_registry.dart';
import 'digraph_registry.dart';
import 'block_registry.dart';
import 'hash_registry.dart';

List<CipherSuite> allSuites(String filter) {
  final all = classicalSuites() +
      polyalphabeticSuites() +
      streamSuites() +
      transpositionSuites() +
      digraphSuites() +
      blockSuites() +
      hashSuites();
  if (filter.isEmpty) return all;
  return all.where((s) => s.name().contains(filter)).toList();
}
