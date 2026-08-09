// Named calculator function: trig sine.
import mathutil from '../mathutil.js';

function trigSine(x) {
  const value = mathutil.guardNumber(x);
  return Math.sin(value);
}

export default { trigSine };
