<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForNoekeon(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="noekeon-detail">
  <MetricRow />
  <p>{detailForNoekeon(rows)}</p>
</div>

<style>
  .noekeon-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
