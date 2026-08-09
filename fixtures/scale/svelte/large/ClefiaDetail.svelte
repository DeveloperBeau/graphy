<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForClefia(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="clefia-detail">
  <MetricRow />
  <p>{detailForClefia(rows)}</p>
</div>

<style>
  .clefia-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
