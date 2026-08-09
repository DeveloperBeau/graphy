import format from './format.js';

function makeBanner(title) {
  return format.underline(format.toUpper(title));
}

function boxed(title) {
  const bar = format.repeat('*', 30);
  return [bar, makeBanner(title), bar].join('\n');
}

export default { makeBanner, boxed };
