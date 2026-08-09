<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForHc128(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hc128-detail">
  <MetricRow />
  <p>{detailForHc128(rows)}</p>
</div>

<style>
  .hc128-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
