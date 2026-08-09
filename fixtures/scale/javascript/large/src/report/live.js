import formatter from './formatter.js';

function emit(result) {
  const line = formatter.formatRow(result);
  process.stdout.write(line + '\n');
  return line;
}

function emitBanner(text) {
  process.stdout.write('--- ' + text + ' ---\n');
}

export default { emit, emitBanner };
