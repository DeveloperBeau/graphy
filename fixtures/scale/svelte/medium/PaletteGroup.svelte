<script>
  import PaletteItem from './PaletteItem.svelte';

  export let state = [];

  function groupTitle(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="palette-group">
  <PaletteItem />
  <p>{groupTitle(state)}</p>
</div>

<style>
  .palette-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
