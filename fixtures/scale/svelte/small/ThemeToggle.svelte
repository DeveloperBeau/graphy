<script>
  export let dark = true;

  function flipScheme() {
    dark = !dark;
    document.documentElement.dataset.scheme = dark ? 'dark' : 'light';
  }
</script>

<button class="theme-toggle" on:click={flipScheme}>
  {dark ? 'Switch to light' : 'Switch to dark'}
</button>

<style>
  .theme-toggle {
    background: transparent;
    border: 1px solid #8892a0;
    border-radius: 6px;
    padding: 0.2rem 0.7rem;
  }
</style>
