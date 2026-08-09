<script>
  export let state = [];

  function chooseUnit(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="dropdown-item-alt">
  <p>{chooseUnit(state)}</p>
</div>

<style>
  .dropdown-item-alt {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
