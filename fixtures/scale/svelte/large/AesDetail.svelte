<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForAes(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="aes-detail">
  <MetricRow />
  <p>{detailForAes(rows)}</p>
</div>

<style>
  .aes-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
