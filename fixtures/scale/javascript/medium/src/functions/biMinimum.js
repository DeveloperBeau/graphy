// Named calculator function: bi minimum.
import mathutil from '../mathutil.js';

function biMinimum(a, b) {
  const left = mathutil.guardNumber(a);
  const right = mathutil.guardNumber(b);
  return Math.min(left, right);
}

export default { biMinimum };
