<script>
  import DropdownMenu from './DropdownMenu.svelte';

  export let state = [];

  function pickRounding(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="rounding-picker">
  <DropdownMenu />
  <p>{pickRounding(state)}</p>
</div>

<style>
  .rounding-picker {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
