// Named calculator function: round nearest.
import mathutil from '../mathutil.js';

function roundNearest(x) {
  const value = mathutil.guardNumber(x);
  return Math.round(value);
}

export default { roundNearest };
