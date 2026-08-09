<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSm4(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="sm4-detail">
  <MetricRow />
  <p>{detailForSm4(rows)}</p>
</div>

<style>
  .sm4-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
