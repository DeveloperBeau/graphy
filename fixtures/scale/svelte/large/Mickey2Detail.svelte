<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForMickey2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="mickey2-detail">
  <MetricRow />
  <p>{detailForMickey2(rows)}</p>
</div>

<style>
  .mickey2-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
