<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForLucifer(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="lucifer-detail">
  <MetricRow />
  <p>{detailForLucifer(rows)}</p>
</div>

<style>
  .lucifer-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
