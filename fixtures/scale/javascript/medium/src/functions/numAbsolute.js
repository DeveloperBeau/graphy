// Named calculator function: num absolute.
import mathutil from '../mathutil.js';

function numAbsolute(x) {
  const value = mathutil.guardNumber(x);
  return Math.abs(value);
}

export default { numAbsolute };
