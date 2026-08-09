<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForBlowfish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="blowfish-detail">
  <MetricRow />
  <p>{detailForBlowfish(rows)}</p>
</div>

<style>
  .blowfish-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
