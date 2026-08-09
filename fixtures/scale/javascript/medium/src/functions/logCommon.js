// Named calculator function: log common.
import mathutil from '../mathutil.js';

function logCommon(x) {
  const value = mathutil.guardPositive(x);
  return Math.log10(value);
}

export default { logCommon };
