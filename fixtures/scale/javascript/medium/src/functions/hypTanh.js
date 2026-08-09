// Named calculator function: hyp tanh.
import mathutil from '../mathutil.js';

function hypTanh(x) {
  const value = mathutil.guardNumber(x);
  return (Math.exp(2 * value) - 1) / (Math.exp(2 * value) + 1);
}

export default { hypTanh };
