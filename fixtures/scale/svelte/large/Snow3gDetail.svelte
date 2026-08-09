<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSnow3g(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="snow3g-detail">
  <MetricRow />
  <p>{detailForSnow3g(rows)}</p>
</div>

<style>
  .snow3g-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
