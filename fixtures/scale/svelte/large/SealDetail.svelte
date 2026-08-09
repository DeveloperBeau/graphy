<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSeal(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="seal-detail">
  <MetricRow />
  <p>{detailForSeal(rows)}</p>
</div>

<style>
  .seal-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
