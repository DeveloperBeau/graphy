// Named calculator function: bi remainder.
import mathutil from '../mathutil.js';

function biRemainder(a, b) {
  const left = mathutil.guardNumber(a);
  const right = mathutil.guardNumber(b);
  return left % right;
}

export default { biRemainder };
