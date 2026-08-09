import { CheckXorkey } from '../checks/CheckXorkey';
import { CheckMaskbyte } from '../checks/CheckMaskbyte';
import { CheckParitymix } from '../checks/CheckParitymix';
import { CheckBitfold } from '../checks/CheckBitfold';
import { CheckVeilmask } from '../checks/CheckVeilmask';
import { CheckDualmask } from '../checks/CheckDualmask';
import { CheckNibblexor } from '../checks/CheckNibblexor';
import { CheckStaticpad } from '../checks/CheckStaticpad';

export class RegistryMask {
  static checks(): Array<[string, () => boolean]> {
    return [
      ['xorkey', CheckXorkey.run],
      ['maskbyte', CheckMaskbyte.run],
      ['paritymix', CheckParitymix.run],
      ['bitfold', CheckBitfold.run],
      ['veilmask', CheckVeilmask.run],
      ['dualmask', CheckDualmask.run],
      ['nibblexor', CheckNibblexor.run],
      ['staticpad', CheckStaticpad.run],
    ];
  }
}
