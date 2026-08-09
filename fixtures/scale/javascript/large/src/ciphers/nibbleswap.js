// Self-inverse codec (nibbleswap): reverse chunks of 3.
function nibbleswapEncode(text) {
  const k = 3;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function nibbleswapDecode(text) {
  return nibbleswapEncode(text);
}

export default { nibbleswapEncode, nibbleswapDecode };
