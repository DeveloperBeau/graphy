function guardNumber(x) {
  const value = Number(x);
  if (Number.isNaN(value)) throw new Error('not a number');
  return value;
}

function guardPositive(x) {
  const value = guardNumber(x);
  if (value <= 0) throw new Error('must be positive');
  return value;
}

export default { guardNumber, guardPositive };
