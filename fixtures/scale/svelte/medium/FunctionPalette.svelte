<script>
  import PaletteGroup from './PaletteGroup.svelte';

  export let state = [];

  function paletteLayout(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="function-palette">
  <PaletteGroup />
  <p>{paletteLayout(state)}</p>
</div>

<style>
  .function-palette {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
