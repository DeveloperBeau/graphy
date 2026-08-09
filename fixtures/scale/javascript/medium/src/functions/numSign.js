// Named calculator function: num sign.
import mathutil from '../mathutil.js';

function numSign(x) {
  const value = mathutil.guardNumber(x);
  return Math.sign(value);
}

export default { numSign };
