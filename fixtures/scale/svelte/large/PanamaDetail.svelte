<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForPanama(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="panama-detail">
  <MetricRow />
  <p>{detailForPanama(rows)}</p>
</div>

<style>
  .panama-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
