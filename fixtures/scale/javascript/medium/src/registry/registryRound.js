import roundFloor from '../functions/roundFloor.js';
import roundCeil from '../functions/roundCeil.js';
import roundNearest from '../functions/roundNearest.js';
import roundTrunc from '../functions/roundTrunc.js';
import numAbsolute from '../functions/numAbsolute.js';
import numSign from '../functions/numSign.js';

function roundTable() {
  return {
    'round_floor': roundFloor.roundFloor,
    'round_ceil': roundCeil.roundCeil,
    'round_nearest': roundNearest.roundNearest,
    'round_trunc': roundTrunc.roundTrunc,
    'num_absolute': numAbsolute.numAbsolute,
    'num_sign': numSign.numSign,
  };
}

export default { roundTable };
