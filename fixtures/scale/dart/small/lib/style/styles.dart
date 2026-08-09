const _esc = 'ESC[';
const _reset = '${_esc}0m';

String bold(String text) => '${_esc}1m$text$_reset';

String dim(String text) => '${_esc}2m$text$_reset';

String underline(String text) => '${_esc}4m$text$_reset';

String colorize(String text, int ansiCode) => '$_esc${ansiCode}m$text$_reset';

String strip(String text) => text.replaceAll(RegExp(r'ESC\[[0-9;]*m'), '');
