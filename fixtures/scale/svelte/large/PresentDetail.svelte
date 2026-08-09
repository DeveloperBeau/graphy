<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForPresent(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="present-detail">
  <MetricRow />
  <p>{detailForPresent(rows)}</p>
</div>

<style>
  .present-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
