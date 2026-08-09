<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForKuznyechik(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="kuznyechik-detail">
  <MetricRow />
  <p>{detailForKuznyechik(rows)}</p>
</div>

<style>
  .kuznyechik-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
