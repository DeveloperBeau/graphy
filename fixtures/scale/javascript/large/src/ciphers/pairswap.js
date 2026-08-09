// Self-inverse codec (pairswap): reverse chunks of 2.
function pairswapEncode(text) {
  const k = 2;
  const parts = [];
  for (let i = 0; i < text.length; i += k) {
    parts.push(text.slice(i, i + k).split('').reverse().join(''));
  }
  return parts.join('');
}

function pairswapDecode(text) {
  return pairswapEncode(text);
}

export default { pairswapEncode, pairswapDecode };
