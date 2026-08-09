// Named calculator function: round ceil.
import mathutil from '../mathutil.js';

function roundCeil(x) {
  const value = mathutil.guardNumber(x);
  return Math.ceil(value);
}

export default { roundCeil };
