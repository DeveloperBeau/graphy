// Named calculator function: pow cube.
import mathutil from '../mathutil.js';

function powCube(x) {
  const value = mathutil.guardPositive(x);
  return value * value * value;
}

export default { powCube };
