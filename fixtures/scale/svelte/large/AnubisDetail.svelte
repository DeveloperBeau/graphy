<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForAnubis(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="anubis-detail">
  <MetricRow />
  <p>{detailForAnubis(rows)}</p>
</div>

<style>
  .anubis-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
