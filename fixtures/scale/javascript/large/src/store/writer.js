import fs from 'fs';
import paths from './paths.js';

function ensureDir() {
  fs.mkdirSync(paths.storeDir(), { recursive: true });
}

function writeResult(name, line) {
  ensureDir();
  fs.appendFileSync(paths.resultPath(name), line + '\n');
}

function clearResult(name) {
  ensureDir();
  fs.writeFileSync(paths.resultPath(name), '');
}

export default { ensureDir, writeResult, clearResult };
