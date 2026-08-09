<script>
  import DropdownItem from './DropdownItem.svelte';

  export let state = [];

  function openMenu(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="dropdown-menu">
  <DropdownItem />
  <p>{openMenu(state)}</p>
</div>

<style>
  .dropdown-menu {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
