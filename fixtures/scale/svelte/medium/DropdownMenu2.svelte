<script>
  import DropdownItem2 from './DropdownItem2.svelte';

  export let state = [];

  function openUnitMenu(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="dropdown-menu-alt">
  <DropdownItem2 />
  <p>{openUnitMenu(state)}</p>
</div>

<style>
  .dropdown-menu-alt {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
