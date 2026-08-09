import checkHexpack from '../checks/checkHexpack.js';
import checkNibbleswap from '../checks/checkNibbleswap.js';
import checkByteflip from '../checks/checkByteflip.js';
import checkPairswap from '../checks/checkPairswap.js';
import checkMirrorpack from '../checks/checkMirrorpack.js';
import checkZigzagpack from '../checks/checkZigzagpack.js';
import checkSplitpack from '../checks/checkSplitpack.js';
import checkLaddercode from '../checks/checkLaddercode.js';
import checkWeavecode from '../checks/checkWeavecode.js';
import checkStridecode from '../checks/checkStridecode.js';

function codecChecks() {
  return [
    ['hexpack', checkHexpack.checkHexpack],
    ['nibbleswap', checkNibbleswap.checkNibbleswap],
    ['byteflip', checkByteflip.checkByteflip],
    ['pairswap', checkPairswap.checkPairswap],
    ['mirrorpack', checkMirrorpack.checkMirrorpack],
    ['zigzagpack', checkZigzagpack.checkZigzagpack],
    ['splitpack', checkSplitpack.checkSplitpack],
    ['laddercode', checkLaddercode.checkLaddercode],
    ['weavecode', checkWeavecode.checkWeavecode],
    ['stridecode', checkStridecode.checkStridecode],
  ];
}

export default { codecChecks };
