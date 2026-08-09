function formatResult(value) {
  if (Number.isInteger(value)) return String(value);
  return value.toFixed(4);
}

function formatLine(expr, value) {
  return expr + ' = ' + formatResult(value);
}

export default { formatResult, formatLine };
