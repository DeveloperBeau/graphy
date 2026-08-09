<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForRabbit(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rabbit-detail">
  <MetricRow />
  <p>{detailForRabbit(rows)}</p>
</div>

<style>
  .rabbit-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
