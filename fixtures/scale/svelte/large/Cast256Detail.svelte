<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForCast256(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cast256-detail">
  <MetricRow />
  <p>{detailForCast256(rows)}</p>
</div>

<style>
  .cast256-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
