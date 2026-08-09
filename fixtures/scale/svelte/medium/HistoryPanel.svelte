<script>
  import HistoryEntry from './HistoryEntry.svelte';
  import HistorySearch from './HistorySearch.svelte';
  import HistoryExport from './HistoryExport.svelte';

  export let state = [];

  function loadHistory(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="history-panel">
  <HistoryEntry />
  <HistorySearch />
  <HistoryExport />
  <p>{loadHistory(state)}</p>
</div>

<style>
  .history-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
