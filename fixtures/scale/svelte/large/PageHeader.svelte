<script>
  import ExportMenu from './ExportMenu.svelte';
  import ThemeSwitch from './ThemeSwitch.svelte';

  export let rows = [];

  function titleForRun(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="page-header">
  <ExportMenu />
  <ThemeSwitch />
  <p>{titleForRun(rows)}</p>
</div>

<style>
  .page-header {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
