<script>
  export let rows = [];

  function sparklinePath(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="trend-sparkline">
  <p>{sparklinePath(rows)}</p>
</div>

<style>
  .trend-sparkline {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
