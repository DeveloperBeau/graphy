// Named calculator function: bi arctangent.
import mathutil from '../mathutil.js';

function biArctangent(a, b) {
  const left = mathutil.guardNumber(a);
  const right = mathutil.guardNumber(b);
  return Math.atan2(left, right);
}

export default { biArctangent };
