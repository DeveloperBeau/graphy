<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForChacha20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="chacha20-detail">
  <MetricRow />
  <p>{detailForChacha20(rows)}</p>
</div>

<style>
  .chacha20-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
