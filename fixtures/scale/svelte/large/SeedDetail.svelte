<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSeed(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="seed-detail">
  <MetricRow />
  <p>{detailForSeed(rows)}</p>
</div>

<style>
  .seed-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
