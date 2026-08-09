<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSalsa20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="salsa20-detail">
  <MetricRow />
  <p>{detailForSalsa20(rows)}</p>
</div>

<style>
  .salsa20-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
