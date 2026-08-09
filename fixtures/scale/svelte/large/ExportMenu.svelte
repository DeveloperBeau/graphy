<script>
  export let rows = [];

  function exportCsv(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="export-menu">
  <p>{exportCsv(rows)}</p>
</div>

<style>
  .export-menu {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
