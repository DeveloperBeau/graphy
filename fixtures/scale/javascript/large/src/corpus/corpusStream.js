// Sample inputs for stream family checks.
function corpusStream() {
  return [
    'running water',
    'wind from the north',
    'quiet before dawn',
  ];
}

function corpusStreamSize() {
  return corpusStream().length;
}

export default { corpusStream, corpusStreamSize };
