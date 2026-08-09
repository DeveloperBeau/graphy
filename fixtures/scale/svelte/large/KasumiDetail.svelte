<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForKasumi(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="kasumi-detail">
  <MetricRow />
  <p>{detailForKasumi(rows)}</p>
</div>

<style>
  .kasumi-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
