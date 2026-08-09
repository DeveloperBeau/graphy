<script>
  import AngleBadge from './AngleBadge.svelte';
  import ThemePicker from './ThemePicker.svelte';

  export let state = [];

  function headerTitle(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="app-header">
  <AngleBadge />
  <ThemePicker />
  <p>{headerTitle(state)}</p>
</div>

<style>
  .app-header {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
