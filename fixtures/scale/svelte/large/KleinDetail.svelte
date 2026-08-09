<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForKlein(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="klein-detail">
  <MetricRow />
  <p>{detailForKlein(rows)}</p>
</div>

<style>
  .klein-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
