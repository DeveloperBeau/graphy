<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForShark(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="shark-detail">
  <MetricRow />
  <p>{detailForShark(rows)}</p>
</div>

<style>
  .shark-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
