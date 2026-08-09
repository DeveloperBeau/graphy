<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSafer(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="safer-detail">
  <MetricRow />
  <p>{detailForSafer(rows)}</p>
</div>

<style>
  .safer-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
