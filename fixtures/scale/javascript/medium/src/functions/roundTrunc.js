// Named calculator function: round trunc.
import mathutil from '../mathutil.js';

function roundTrunc(x) {
  const value = mathutil.guardNumber(x);
  return Math.trunc(value);
}

export default { roundTrunc };
