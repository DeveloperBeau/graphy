<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForXchacha20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xchacha20-detail">
  <MetricRow />
  <p>{detailForXchacha20(rows)}</p>
</div>

<style>
  .xchacha20-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
