import { ConvRadians } from '../functions/ConvRadians';
import { ConvDegrees } from '../functions/ConvDegrees';
import { ConvCelsius } from '../functions/ConvCelsius';
import { ConvFahrenheit } from '../functions/ConvFahrenheit';

export class RegistryConvert {
  static table(): Record<string, (...args: number[]) => number> {
    return {
      'conv_radians': ConvRadians.apply,
      'conv_degrees': ConvDegrees.apply,
      'conv_celsius': ConvCelsius.apply,
      'conv_fahrenheit': ConvFahrenheit.apply,
    };
  }
}
