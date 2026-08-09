<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSquare(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="square-detail">
  <MetricRow />
  <p>{detailForSquare(rows)}</p>
</div>

<style>
  .square-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
