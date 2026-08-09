// Sample inputs for codec family checks.
function corpusCodec() {
  return [
    'pack and unpack',
    'mirror the message',
    'swap every pair',
  ];
}

function corpusCodecSize() {
  return corpusCodec().length;
}

export default { corpusCodec, corpusCodecSize };
