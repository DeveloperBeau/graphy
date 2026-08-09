<script>
  export let state = [];

  function exportTapeCsv(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="history-export">
  <p>{exportTapeCsv(state)}</p>
</div>

<style>
  .history-export {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
