<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForAria(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="aria-detail">
  <MetricRow />
  <p>{detailForAria(rows)}</p>
</div>

<style>
  .aria-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
