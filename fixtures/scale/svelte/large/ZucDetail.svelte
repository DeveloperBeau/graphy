<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForZuc(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="zuc-detail">
  <MetricRow />
  <p>{detailForZuc(rows)}</p>
</div>

<style>
  .zuc-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
