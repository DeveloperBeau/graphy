import '../../core/cipher.dart';
import '../../util/bytes.dart';
import '../../util/hex.dart';
import '../feistel/feistel_key.dart';
import '../feistel/feistel_network.dart';
import 'ctr_key.dart';
import 'ctr_keystream.dart';

/// Counter mode: encrypt a counter stream, xor it with the data.
class CtrModeCipher implements Cipher {
  final FeistelNetwork _network;
  final CtrModeKey key;

  CtrModeCipher(this.key) : _network = FeistelNetwork(FeistelKey(key.blockKey));

  @override
  String name() => 'ctr';

  @override
  String encrypt(String plaintext) => hexEncode(ctrMask(_network, key.nonce(), bytesOf(plaintext)));

  @override
  String decrypt(String ciphertext) => bytesToText(ctrMask(_network, key.nonce(), hexDecode(ciphertext)));
}
