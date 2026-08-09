// Named calculator function: conv fahrenheit.
import mathutil from '../mathutil.js';

function convFahrenheit(x) {
  const value = mathutil.guardNumber(x);
  return value * 9 / 5 + 32;
}

export default { convFahrenheit };
