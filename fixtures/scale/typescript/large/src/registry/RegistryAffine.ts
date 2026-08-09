import { CheckAffine } from '../checks/CheckAffine';
import { CheckDecimation } from '../checks/CheckDecimation';
import { CheckPromoter } from '../checks/CheckPromoter';
import { CheckModwheel } from '../checks/CheckModwheel';
import { CheckLinearmix } from '../checks/CheckLinearmix';
import { CheckSkewmap } from '../checks/CheckSkewmap';

export class RegistryAffine {
  static checks(): Array<[string, () => boolean]> {
    return [
      ['affine', CheckAffine.run],
      ['decimation', CheckDecimation.run],
      ['promoter', CheckPromoter.run],
      ['modwheel', CheckModwheel.run],
      ['linearmix', CheckLinearmix.run],
      ['skewmap', CheckSkewmap.run],
    ];
  }
}
