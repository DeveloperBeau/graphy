<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForIdea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="idea-detail">
  <MetricRow />
  <p>{detailForIdea(rows)}</p>
</div>

<style>
  .idea-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
