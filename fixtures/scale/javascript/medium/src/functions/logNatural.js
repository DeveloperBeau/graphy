// Named calculator function: log natural.
import mathutil from '../mathutil.js';

function logNatural(x) {
  const value = mathutil.guardPositive(x);
  return Math.log(value);
}

export default { logNatural };
