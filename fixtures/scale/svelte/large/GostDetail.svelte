<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForGost(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="gost-detail">
  <MetricRow />
  <p>{detailForGost(rows)}</p>
</div>

<style>
  .gost-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
