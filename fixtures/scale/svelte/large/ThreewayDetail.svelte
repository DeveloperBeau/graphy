<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForThreeway(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="threeway-detail">
  <MetricRow />
  <p>{detailForThreeway(rows)}</p>
</div>

<style>
  .threeway-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
