const THEMES = {
  plain: { corner: '+', edge: '-', side: '|' },
  star: { corner: '*', edge: '*', side: '*' },
  dot: { corner: '.', edge: '.', side: ':' },
};

function themeChars(name) {
  return THEMES[name] || THEMES.plain;
}

export default { themeChars };
