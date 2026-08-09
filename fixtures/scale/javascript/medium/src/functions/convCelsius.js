// Named calculator function: conv celsius.
import mathutil from '../mathutil.js';

function convCelsius(x) {
  const value = mathutil.guardNumber(x);
  return (value - 32) * 5 / 9;
}

export default { convCelsius };
