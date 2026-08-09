class CipherError extends Error {}

function unknownCipher(name) {
  return new CipherError('unknown cipher: ' + name);
}

function roundtripFailed(name) {
  return new CipherError('round trip mismatch: ' + name);
}

export { CipherError };
export default { unknownCipher, roundtripFailed };
