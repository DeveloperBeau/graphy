import { CheckBlockrotate } from '../checks/CheckBlockrotate';
import { CheckRingshift } from '../checks/CheckRingshift';
import { CheckCarousel } from '../checks/CheckCarousel';
import { CheckConveyor } from '../checks/CheckConveyor';
import { CheckTurnstile } from '../checks/CheckTurnstile';
import { CheckWindmill } from '../checks/CheckWindmill';
import { CheckFerris } from '../checks/CheckFerris';
import { CheckLattice } from '../checks/CheckLattice';

export class RegistryRotate {
  static checks(): Array<[string, () => boolean]> {
    return [
      ['blockrotate', CheckBlockrotate.run],
      ['ringshift', CheckRingshift.run],
      ['carousel', CheckCarousel.run],
      ['conveyor', CheckConveyor.run],
      ['turnstile', CheckTurnstile.run],
      ['windmill', CheckWindmill.run],
      ['ferris', CheckFerris.run],
      ['lattice', CheckLattice.run],
    ];
  }
}
