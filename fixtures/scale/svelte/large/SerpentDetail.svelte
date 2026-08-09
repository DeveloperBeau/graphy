<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSerpent(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="serpent-detail">
  <MetricRow />
  <p>{detailForSerpent(rows)}</p>
</div>

<style>
  .serpent-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
