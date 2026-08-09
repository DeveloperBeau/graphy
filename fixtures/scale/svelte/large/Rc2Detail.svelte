<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForRc2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc2-detail">
  <MetricRow />
  <p>{detailForRc2(rows)}</p>
</div>

<style>
  .rc2-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
