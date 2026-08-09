export interface ThemeChars {
  corner: string;
  edge: string;
  side: string;
}

const THEMES: Record<string, ThemeChars> = {
  plain: { corner: '+', edge: '-', side: '|' },
  star: { corner: '*', edge: '*', side: '*' },
  dot: { corner: '.', edge: '.', side: ':' },
};

export class Theme {
  static chars(name: string): ThemeChars {
    return THEMES[name] || THEMES.plain;
  }
}
