import checkXorkey from '../checks/checkXorkey.js';
import checkMaskbyte from '../checks/checkMaskbyte.js';
import checkParitymix from '../checks/checkParitymix.js';
import checkBitfold from '../checks/checkBitfold.js';
import checkVeilmask from '../checks/checkVeilmask.js';
import checkDualmask from '../checks/checkDualmask.js';
import checkNibblexor from '../checks/checkNibblexor.js';
import checkStaticpad from '../checks/checkStaticpad.js';

function maskChecks() {
  return [
    ['xorkey', checkXorkey.checkXorkey],
    ['maskbyte', checkMaskbyte.checkMaskbyte],
    ['paritymix', checkParitymix.checkParitymix],
    ['bitfold', checkBitfold.checkBitfold],
    ['veilmask', checkVeilmask.checkVeilmask],
    ['dualmask', checkDualmask.checkDualmask],
    ['nibblexor', checkNibblexor.checkNibblexor],
    ['staticpad', checkStaticpad.checkStaticpad],
  ];
}

export default { maskChecks };
