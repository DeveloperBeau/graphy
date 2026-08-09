import { CheckCaesar } from '../checks/CheckCaesar';
import { CheckGronsfeld } from '../checks/CheckGronsfeld';
import { CheckTrithemius } from '../checks/CheckTrithemius';
import { CheckShiftreel } from '../checks/CheckShiftreel';
import { CheckStairstep } from '../checks/CheckStairstep';
import { CheckAugustus } from '../checks/CheckAugustus';
import { CheckKeypad } from '../checks/CheckKeypad';
import { CheckOrdinal } from '../checks/CheckOrdinal';

export class RegistryAdditive {
  static checks(): Array<[string, () => boolean]> {
    return [
      ['caesar', CheckCaesar.run],
      ['gronsfeld', CheckGronsfeld.run],
      ['trithemius', CheckTrithemius.run],
      ['shiftreel', CheckShiftreel.run],
      ['stairstep', CheckStairstep.run],
      ['augustus', CheckAugustus.run],
      ['keypad', CheckKeypad.run],
      ['ordinal', CheckOrdinal.run],
    ];
  }
}
