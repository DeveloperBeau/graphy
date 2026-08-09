<script>
  export let state = [];

  function restoreEntry(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="history-entry">
  <p>{restoreEntry(state)}</p>
</div>

<style>
  .history-entry {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
