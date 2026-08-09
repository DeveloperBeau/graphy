<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForTea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="tea-detail">
  <MetricRow />
  <p>{detailForTea(rows)}</p>
</div>

<style>
  .tea-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
