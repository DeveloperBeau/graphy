import { TrigSine } from '../functions/TrigSine';
import { TrigCosine } from '../functions/TrigCosine';
import { TrigTangent } from '../functions/TrigTangent';
import { TrigArctan } from '../functions/TrigArctan';
import { HypSinh } from '../functions/HypSinh';
import { HypCosh } from '../functions/HypCosh';
import { HypTanh } from '../functions/HypTanh';

export class RegistryTrig {
  static table(): Record<string, (...args: number[]) => number> {
    return {
      'trig_sine': TrigSine.apply,
      'trig_cosine': TrigCosine.apply,
      'trig_tangent': TrigTangent.apply,
      'trig_arctan': TrigArctan.apply,
      'hyp_sinh': HypSinh.apply,
      'hyp_cosh': HypCosh.apply,
      'hyp_tanh': HypTanh.apply,
    };
  }
}
