<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForFeal(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="feal-detail">
  <MetricRow />
  <p>{detailForFeal(rows)}</p>
</div>

<style>
  .feal-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
