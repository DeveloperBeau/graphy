// Named calculator function: pow cbrt.
import mathutil from '../mathutil.js';

function powCbrt(x) {
  const value = mathutil.guardPositive(x);
  return Math.cbrt(value);
}

export default { powCbrt };
