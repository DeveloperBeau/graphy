import checkAffine from '../checks/checkAffine.js';
import checkDecimation from '../checks/checkDecimation.js';
import checkPromoter from '../checks/checkPromoter.js';
import checkModwheel from '../checks/checkModwheel.js';
import checkLinearmix from '../checks/checkLinearmix.js';
import checkSkewmap from '../checks/checkSkewmap.js';

function affineChecks() {
  return [
    ['affine', checkAffine.checkAffine],
    ['decimation', checkDecimation.checkDecimation],
    ['promoter', checkPromoter.checkPromoter],
    ['modwheel', checkModwheel.checkModwheel],
    ['linearmix', checkLinearmix.checkLinearmix],
    ['skewmap', checkSkewmap.checkSkewmap],
  ];
}

export default { affineChecks };
