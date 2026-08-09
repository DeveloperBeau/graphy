// Sample inputs for additive family checks.
function corpusAdditive() {
  return [
    'attack at dawn',
    'meet me at noon',
    'the package is ready',
  ];
}

function corpusAdditiveSize() {
  return corpusAdditive().length;
}

export default { corpusAdditive, corpusAdditiveSize };
