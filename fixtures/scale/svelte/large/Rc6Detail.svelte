<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForRc6(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc6-detail">
  <MetricRow />
  <p>{detailForRc6(rows)}</p>
</div>

<style>
  .rc6-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
