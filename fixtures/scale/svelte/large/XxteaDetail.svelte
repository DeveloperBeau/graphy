<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForXxtea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xxtea-detail">
  <MetricRow />
  <p>{detailForXxtea(rows)}</p>
</div>

<style>
  .xxtea-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
