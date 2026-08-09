// Named calculator function: bi maximum.
import mathutil from '../mathutil.js';

function biMaximum(a, b) {
  const left = mathutil.guardNumber(a);
  const right = mathutil.guardNumber(b);
  return Math.max(left, right);
}

export default { biMaximum };
