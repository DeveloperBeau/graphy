// Named calculator function: trig tangent.
import mathutil from '../mathutil.js';

function trigTangent(x) {
  const value = mathutil.guardNumber(x);
  return Math.tan(value);
}

export default { trigTangent };
