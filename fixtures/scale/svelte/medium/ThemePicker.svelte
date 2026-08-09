<script>
  import ThemeSwatch from './ThemeSwatch.svelte';

  export let state = [];

  function applyTheme(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="theme-picker">
  <ThemeSwatch />
  <p>{applyTheme(state)}</p>
</div>

<style>
  .theme-picker {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
