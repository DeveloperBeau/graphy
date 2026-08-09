<script>
  export let rows = [];

  function formatMetric(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="metric-row">
  <p>{formatMetric(rows)}</p>
</div>

<style>
  .metric-row {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
