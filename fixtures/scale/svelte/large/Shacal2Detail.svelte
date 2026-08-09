<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForShacal2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="shacal2-detail">
  <MetricRow />
  <p>{detailForShacal2(rows)}</p>
</div>

<style>
  .shacal2-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
