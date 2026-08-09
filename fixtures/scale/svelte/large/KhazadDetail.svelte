<script>
  import MetricRow from './MetricRow.svelte';

  export let rows = [];

  function detailForKhazad(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="khazad-detail">
  <MetricRow />
  <p>{detailForKhazad(rows)}</p>
</div>

<style>
  .khazad-detail {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
