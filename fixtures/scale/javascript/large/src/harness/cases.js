function sampleTexts() {
  return ['attack at dawn', 'the quick brown fox', 'hello world'];
}

function sampleKeys() {
  return { caesar: 7, xorkey: 3, lcgstream: 11, carousel: 5 };
}

function buildCases() {
  const keys = sampleKeys();
  const cases = [];
  for (const name of Object.keys(keys)) {
    for (const text of sampleTexts()) cases.push([name, text, keys[name]]);
  }
  return cases;
}

export default { sampleTexts, sampleKeys, buildCases };
