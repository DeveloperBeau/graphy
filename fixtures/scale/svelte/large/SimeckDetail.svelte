<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForSimeck(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="simeck-detail">
  <MetricRow />
  <p>{detailForSimeck(rows)}</p>
</div>

<style>
  .simeck-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
