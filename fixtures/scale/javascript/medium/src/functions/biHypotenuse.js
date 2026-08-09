// Named calculator function: bi hypotenuse.
import mathutil from '../mathutil.js';

function biHypotenuse(a, b) {
  const left = mathutil.guardNumber(a);
  const right = mathutil.guardNumber(b);
  return Math.sqrt(left * left + right * right);
}

export default { biHypotenuse };
