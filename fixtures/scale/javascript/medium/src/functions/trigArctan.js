// Named calculator function: trig arctan.
import mathutil from '../mathutil.js';

function trigArctan(x) {
  const value = mathutil.guardNumber(x);
  return Math.atan(value);
}

export default { trigArctan };
