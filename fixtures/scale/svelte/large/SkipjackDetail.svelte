<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSkipjack(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="skipjack-detail">
  <MetricRow />
  <p>{detailForSkipjack(rows)}</p>
</div>

<style>
  .skipjack-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
