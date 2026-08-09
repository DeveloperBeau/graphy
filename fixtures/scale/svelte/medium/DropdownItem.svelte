<script>
  export let state = [];

  function chooseItem(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="dropdown-item">
  <p>{chooseItem(state)}</p>
</div>

<style>
  .dropdown-item {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
