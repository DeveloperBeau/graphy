<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForIsaac(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="isaac-detail">
  <MetricRow />
  <p>{detailForIsaac(rows)}</p>
</div>

<style>
  .isaac-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
