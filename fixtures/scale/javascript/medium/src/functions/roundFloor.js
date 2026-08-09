// Named calculator function: round floor.
import mathutil from '../mathutil.js';

function roundFloor(x) {
  const value = mathutil.guardNumber(x);
  return Math.floor(value);
}

export default { roundFloor };
