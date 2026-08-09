<script>
  export let state = [];

  function swatchStyle(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="theme-swatch">
  <p>{swatchStyle(state)}</p>
</div>

<style>
  .theme-swatch {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
