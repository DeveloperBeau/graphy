import checkCaesar from '../checks/checkCaesar.js';
import checkGronsfeld from '../checks/checkGronsfeld.js';
import checkTrithemius from '../checks/checkTrithemius.js';
import checkShiftreel from '../checks/checkShiftreel.js';
import checkStairstep from '../checks/checkStairstep.js';
import checkAugustus from '../checks/checkAugustus.js';
import checkKeypad from '../checks/checkKeypad.js';
import checkOrdinal from '../checks/checkOrdinal.js';

function additiveChecks() {
  return [
    ['caesar', checkCaesar.checkCaesar],
    ['gronsfeld', checkGronsfeld.checkGronsfeld],
    ['trithemius', checkTrithemius.checkTrithemius],
    ['shiftreel', checkShiftreel.checkShiftreel],
    ['stairstep', checkStairstep.checkStairstep],
    ['augustus', checkAugustus.checkAugustus],
    ['keypad', checkKeypad.checkKeypad],
    ['ordinal', checkOrdinal.checkOrdinal],
  ];
}

export default { additiveChecks };
