<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForThreefish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="threefish-detail">
  <MetricRow />
  <p>{detailForThreefish(rows)}</p>
</div>

<style>
  .threefish-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
