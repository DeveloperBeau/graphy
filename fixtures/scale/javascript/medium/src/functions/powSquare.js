// Named calculator function: pow square.
import mathutil from '../mathutil.js';

function powSquare(x) {
  const value = mathutil.guardPositive(x);
  return value * value;
}

export default { powSquare };
