<script>
  import ThemeToggle from './ThemeToggle.svelte';

  export let title = 'inkroll preview';

  function subtitle() {
    return 'streaming formatter, in the browser';
  }
</script>

<header class="app-header">
  <h1>{title}</h1>
  <p>{subtitle()}</p>
  <ThemeToggle />
</header>

<style>
  .app-header {
    display: flex;
    align-items: baseline;
    gap: 1rem;
  }
</style>
