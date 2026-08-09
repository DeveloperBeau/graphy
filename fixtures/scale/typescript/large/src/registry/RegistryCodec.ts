import { CheckHexpack } from '../checks/CheckHexpack';
import { CheckNibbleswap } from '../checks/CheckNibbleswap';
import { CheckByteflip } from '../checks/CheckByteflip';
import { CheckPairswap } from '../checks/CheckPairswap';
import { CheckMirrorpack } from '../checks/CheckMirrorpack';
import { CheckZigzagpack } from '../checks/CheckZigzagpack';
import { CheckSplitpack } from '../checks/CheckSplitpack';
import { CheckLaddercode } from '../checks/CheckLaddercode';
import { CheckWeavecode } from '../checks/CheckWeavecode';
import { CheckStridecode } from '../checks/CheckStridecode';

export class RegistryCodec {
  static checks(): Array<[string, () => boolean]> {
    return [
      ['hexpack', CheckHexpack.run],
      ['nibbleswap', CheckNibbleswap.run],
      ['byteflip', CheckByteflip.run],
      ['pairswap', CheckPairswap.run],
      ['mirrorpack', CheckMirrorpack.run],
      ['zigzagpack', CheckZigzagpack.run],
      ['splitpack', CheckSplitpack.run],
      ['laddercode', CheckLaddercode.run],
      ['weavecode', CheckWeavecode.run],
      ['stridecode', CheckStridecode.run],
    ];
  }
}
