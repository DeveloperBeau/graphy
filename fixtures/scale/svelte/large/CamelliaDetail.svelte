<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForCamellia(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="camellia-detail">
  <MetricRow />
  <p>{detailForCamellia(rows)}</p>
</div>

<style>
  .camellia-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
