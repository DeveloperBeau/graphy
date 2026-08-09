// Named calculator function: conv degrees.
import mathutil from '../mathutil.js';

function convDegrees(x) {
  const value = mathutil.guardNumber(x);
  return value * 180 / Math.PI;
}

export default { convDegrees };
