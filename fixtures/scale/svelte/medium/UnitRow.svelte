<script>
  import DropdownMenu2 from './DropdownMenu2.svelte';

  export let state = [];

  function rowUnits(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="unit-row">
  <DropdownMenu2 />
  <p>{rowUnits(state)}</p>
</div>

<style>
  .unit-row {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
