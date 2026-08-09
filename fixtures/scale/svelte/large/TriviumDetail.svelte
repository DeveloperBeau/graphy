<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForTrivium(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="trivium-detail">
  <MetricRow />
  <p>{detailForTrivium(rows)}</p>
</div>

<style>
  .trivium-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
