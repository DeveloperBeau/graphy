import biArctangent from '../functions/biArctangent.js';
import biRemainder from '../functions/biRemainder.js';
import biMaximum from '../functions/biMaximum.js';
import biMinimum from '../functions/biMinimum.js';
import biHypotenuse from '../functions/biHypotenuse.js';

function binaryTable() {
  return {
    'bi_arctangent': biArctangent.biArctangent,
    'bi_remainder': biRemainder.biRemainder,
    'bi_maximum': biMaximum.biMaximum,
    'bi_minimum': biMinimum.biMinimum,
    'bi_hypotenuse': biHypotenuse.biHypotenuse,
  };
}

export default { binaryTable };
