<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForPrince(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="prince-detail">
  <MetricRow />
  <p>{detailForPrince(rows)}</p>
</div>

<style>
  .prince-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
