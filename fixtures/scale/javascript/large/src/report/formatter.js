function formatRow(result) {
  const status = result.ok ? 'OK ' : 'BAD';
  return status + ' ' + result.name.padEnd(12) + ' fp=' + result.sealedFp + ' ' + result.ms + 'ms';
}

function formatHeader() {
  return '=== cipher round-trip report ===';
}

function formatCheck(name, ok) {
  return (ok ? 'PASS' : 'FAIL') + ' check ' + name;
}

export default { formatRow, formatHeader, formatCheck };
