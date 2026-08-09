// Sample inputs for hash family checks.
function corpusHash() {
  return [
    'checksum this line',
    'integrity matters',
    'verify everything twice',
  ];
}

function corpusHashSize() {
  return corpusHash().length;
}

export default { corpusHash, corpusHashSize };
