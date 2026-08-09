<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForTwofish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="twofish-detail">
  <MetricRow />
  <p>{detailForTwofish(rows)}</p>
</div>

<style>
  .twofish-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
