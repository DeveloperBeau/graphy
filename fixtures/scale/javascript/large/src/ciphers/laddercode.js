// Self-inverse codec (laddercode): reverse chunks of 3.
function laddercodeEncode(text) {
  const k = 3;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function laddercodeDecode(text) {
  return laddercodeEncode(text);
}

export default { laddercodeEncode, laddercodeDecode };
