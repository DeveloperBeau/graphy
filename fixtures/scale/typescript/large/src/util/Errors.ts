export class CipherError extends Error {}

export class Errors {
  static unknownCipher(name: string): CipherError {
    return new CipherError('unknown cipher: ' + name);
  }

  static roundtripFailed(name: string): CipherError {
    return new CipherError('round trip mismatch: ' + name);
  }
}
