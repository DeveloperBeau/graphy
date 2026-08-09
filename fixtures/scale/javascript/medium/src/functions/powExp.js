// Named calculator function: pow exp.
import mathutil from '../mathutil.js';

function powExp(x) {
  const value = mathutil.guardPositive(x);
  return Math.exp(value);
}

export default { powExp };
