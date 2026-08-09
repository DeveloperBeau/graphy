<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForLea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="lea-detail">
  <MetricRow />
  <p>{detailForLea(rows)}</p>
</div>

<style>
  .lea-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
