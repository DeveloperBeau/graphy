<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForHight(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hight-detail">
  <MetricRow />
  <p>{detailForHight(rows)}</p>
</div>

<style>
  .hight-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
