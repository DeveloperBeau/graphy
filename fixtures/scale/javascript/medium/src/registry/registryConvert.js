import convRadians from '../functions/convRadians.js';
import convDegrees from '../functions/convDegrees.js';
import convCelsius from '../functions/convCelsius.js';
import convFahrenheit from '../functions/convFahrenheit.js';

function convertTable() {
  return {
    'conv_radians': convRadians.convRadians,
    'conv_degrees': convDegrees.convDegrees,
    'conv_celsius': convCelsius.convCelsius,
    'conv_fahrenheit': convFahrenheit.convFahrenheit,
  };
}

export default { convertTable };
