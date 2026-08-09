import fs from 'fs';
import paths from './paths.js';

function readResult(name) {
  const p = paths.resultPath(name);
  if (!fs.existsSync(p)) return [];
  return fs.readFileSync(p, 'utf8').split('\n').filter((l) => l.length > 0);
}

function countLines(name) {
  return readResult(name).length;
}

export default { readResult, countLines };
