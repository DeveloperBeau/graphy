<script>
  import SearchBox from './SearchBox.svelte';

  export let rows = [];

  function applyFilters(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="filter-bar">
  <SearchBox />
  <p>{applyFilters(rows)}</p>
</div>

<style>
  .filter-bar {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
