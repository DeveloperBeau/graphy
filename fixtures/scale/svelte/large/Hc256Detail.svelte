<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForHc256(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hc256-detail">
  <MetricRow />
  <p>{detailForHc256(rows)}</p>
</div>

<style>
  .hc256-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
