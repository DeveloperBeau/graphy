// Named calculator function: hyp sinh.
import mathutil from '../mathutil.js';

function hypSinh(x) {
  const value = mathutil.guardNumber(x);
  return (Math.exp(value) - Math.exp(-value)) / 2;
}

export default { hypSinh };
