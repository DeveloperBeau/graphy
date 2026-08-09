// Rotation transposition cipher (carousel).
function carouselOffset(text, key) {
  return (key + 5) % Math.max(1, text.length);
}

function carouselEncrypt(text, key) {
  const n = carouselOffset(text, key);
  return text.slice(n) + text.slice(0, n);
}

function carouselDecrypt(text, key) {
  const n = carouselOffset(text, key);
  return text.slice(text.length - n) + text.slice(0, text.length - n);
}

export default { carouselOffset, carouselEncrypt, carouselDecrypt };
