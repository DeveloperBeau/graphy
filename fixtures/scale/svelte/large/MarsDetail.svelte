<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForMars(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="mars-detail">
  <MetricRow />
  <p>{detailForMars(rows)}</p>
</div>

<style>
  .mars-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
