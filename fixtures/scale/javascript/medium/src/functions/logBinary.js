// Named calculator function: log binary.
import mathutil from '../mathutil.js';

function logBinary(x) {
  const value = mathutil.guardPositive(x);
  return Math.log2(value);
}

export default { logBinary };
