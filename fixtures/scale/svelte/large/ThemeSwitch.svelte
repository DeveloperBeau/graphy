<script>
  export let rows = [];

  function flipTheme(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="theme-switch">
  <p>{flipTheme(rows)}</p>
</div>

<style>
  .theme-switch {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
