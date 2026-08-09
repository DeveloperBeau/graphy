import { CheckFnvhash } from '../checks/CheckFnvhash';
import { CheckDjbhash } from '../checks/CheckDjbhash';
import { CheckSdbmhash } from '../checks/CheckSdbmhash';
import { CheckJenkinshash } from '../checks/CheckJenkinshash';
import { CheckPearsonhash } from '../checks/CheckPearsonhash';
import { CheckFoldsum } from '../checks/CheckFoldsum';
import { CheckMixcrc } from '../checks/CheckMixcrc';
import { CheckTallyhash } from '../checks/CheckTallyhash';
import { CheckChainhash } from '../checks/CheckChainhash';
import { CheckWeavehash } from '../checks/CheckWeavehash';

export class RegistryHash {
  static checks(): Array<[string, () => boolean]> {
    return [
      ['fnvhash', CheckFnvhash.run],
      ['djbhash', CheckDjbhash.run],
      ['sdbmhash', CheckSdbmhash.run],
      ['jenkinshash', CheckJenkinshash.run],
      ['pearsonhash', CheckPearsonhash.run],
      ['foldsum', CheckFoldsum.run],
      ['mixcrc', CheckMixcrc.run],
      ['tallyhash', CheckTallyhash.run],
      ['chainhash', CheckChainhash.run],
      ['weavehash', CheckWeavehash.run],
    ];
  }
}
