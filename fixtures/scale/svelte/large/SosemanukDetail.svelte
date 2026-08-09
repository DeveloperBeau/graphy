<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSosemanuk(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="sosemanuk-detail">
  <MetricRow />
  <p>{detailForSosemanuk(rows)}</p>
</div>

<style>
  .sosemanuk-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
