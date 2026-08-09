import path from 'path';

function storeDir() {
  return path.join(process.cwd(), 'runs');
}

function resultPath(name) {
  return path.join(storeDir(), name + '.log');
}

export default { storeDir, resultPath };
