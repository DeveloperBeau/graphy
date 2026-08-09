// Named calculator function: pow sqrt.
import mathutil from '../mathutil.js';

function powSqrt(x) {
  const value = mathutil.guardPositive(x);
  return Math.sqrt(value);
}

export default { powSqrt };
