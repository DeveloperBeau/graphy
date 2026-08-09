<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForCast5(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="cast5-detail">
  <MetricRow />
  <p>{detailForCast5(rows)}</p>
</div>

<style>
  .cast5-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
