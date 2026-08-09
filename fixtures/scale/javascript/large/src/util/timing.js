function nowMs() {
  return Date.now();
}

function elapsed(start) {
  return nowMs() - start;
}

function formatMs(ms) {
  return ms + 'ms';
}

export default { nowMs, elapsed, formatMs };
