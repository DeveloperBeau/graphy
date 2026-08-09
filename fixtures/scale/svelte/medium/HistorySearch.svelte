<script>
  export let state = [];

  function filterEntries(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="history-search">
  <p>{filterEntries(state)}</p>
</div>

<style>
  .history-search {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
