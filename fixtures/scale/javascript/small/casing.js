function titleCase(text) {
  return text
    .split(' ')
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
    .join(' ');
}

function shoutCase(text) {
  return text.toUpperCase() + '!';
}

export default { titleCase, shoutCase };
