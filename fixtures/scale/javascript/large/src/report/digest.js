import codec from '../core/codec.js';

function digestLine(result) {
  return result.name + ':' + codec.fingerprint(result.sealedFp);
}

function digestAll(results) {
  return results.map(digestLine).join('|');
}

export default { digestLine, digestAll };
