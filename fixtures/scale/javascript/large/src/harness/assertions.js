import errors from '../util/errors.js';

function assertOk(result) {
  if (!result.ok) throw errors.roundtripFailed(result.name);
  return true;
}

function countOk(results) {
  return results.filter((r) => r.ok).length;
}

export default { assertOk, countOk };
