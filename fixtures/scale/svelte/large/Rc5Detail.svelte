<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForRc5(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc5-detail">
  <MetricRow />
  <p>{detailForRc5(rows)}</p>
</div>

<style>
  .rc5-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
