<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForRc4(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rc4-detail">
  <MetricRow />
  <p>{detailForRc4(rows)}</p>
</div>

<style>
  .rc4-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
