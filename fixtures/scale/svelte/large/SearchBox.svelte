<script>
  export let rows = [];

  function debounceQuery(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="search-box">
  <p>{debounceQuery(rows)}</p>
</div>

<style>
  .search-box {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
