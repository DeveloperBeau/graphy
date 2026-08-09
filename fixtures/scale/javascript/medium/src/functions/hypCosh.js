// Named calculator function: hyp cosh.
import mathutil from '../mathutil.js';

function hypCosh(x) {
  const value = mathutil.guardNumber(x);
  return (Math.exp(value) + Math.exp(-value)) / 2;
}

export default { hypCosh };
