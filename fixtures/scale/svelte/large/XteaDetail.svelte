<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForXtea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xtea-detail">
  <MetricRow />
  <p>{detailForXtea(rows)}</p>
</div>

<style>
  .xtea-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
