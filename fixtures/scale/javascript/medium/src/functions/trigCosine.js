// Named calculator function: trig cosine.
import mathutil from '../mathutil.js';

function trigCosine(x) {
  const value = mathutil.guardNumber(x);
  return Math.cos(value);
}

export default { trigCosine };
