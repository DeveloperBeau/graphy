<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForBaseking(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="baseking-detail">
  <MetricRow />
  <p>{detailForBaseking(rows)}</p>
</div>

<style>
  .baseking-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
