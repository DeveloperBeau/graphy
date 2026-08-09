<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSpeck(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="speck-detail">
  <MetricRow />
  <p>{detailForSpeck(rows)}</p>
</div>

<style>
  .speck-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
