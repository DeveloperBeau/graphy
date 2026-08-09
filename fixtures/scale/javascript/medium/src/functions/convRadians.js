// Named calculator function: conv radians.
import mathutil from '../mathutil.js';

function convRadians(x) {
  const value = mathutil.guardNumber(x);
  return value * Math.PI / 180;
}

export default { convRadians };
