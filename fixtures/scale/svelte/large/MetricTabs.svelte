<script>
  export let rows = [];

  function switchMetric(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="metric-tabs">
  <p>{switchMetric(rows)}</p>
</div>

<style>
  .metric-tabs {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
