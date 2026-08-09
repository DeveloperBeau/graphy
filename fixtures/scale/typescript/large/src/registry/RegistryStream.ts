import { CheckLcgstream } from '../checks/CheckLcgstream';
import { CheckDriftstream } from '../checks/CheckDriftstream';
import { CheckPulsestream } from '../checks/CheckPulsestream';
import { CheckCascadestream } from '../checks/CheckCascadestream';
import { CheckOrbitstream } from '../checks/CheckOrbitstream';
import { CheckEmberstream } from '../checks/CheckEmberstream';
import { CheckRiverstream } from '../checks/CheckRiverstream';
import { CheckSparkstream } from '../checks/CheckSparkstream';

export class RegistryStream {
  static checks(): Array<[string, () => boolean]> {
    return [
      ['lcgstream', CheckLcgstream.run],
      ['driftstream', CheckDriftstream.run],
      ['pulsestream', CheckPulsestream.run],
      ['cascadestream', CheckCascadestream.run],
      ['orbitstream', CheckOrbitstream.run],
      ['emberstream', CheckEmberstream.run],
      ['riverstream', CheckRiverstream.run],
      ['sparkstream', CheckSparkstream.run],
    ];
  }
}
