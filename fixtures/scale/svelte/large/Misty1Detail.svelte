<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForMisty1(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="misty1-detail">
  <MetricRow />
  <p>{detailForMisty1(rows)}</p>
</div>

<style>
  .misty1-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
