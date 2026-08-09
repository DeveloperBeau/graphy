<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForGrain(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="grain-detail">
  <MetricRow />
  <p>{detailForGrain(rows)}</p>
</div>

<style>
  .grain-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
