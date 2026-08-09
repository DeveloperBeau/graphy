<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSimon(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="simon-detail">
  <MetricRow />
  <p>{detailForSimon(rows)}</p>
</div>

<style>
  .simon-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
