<script>
  export let state = [];

  function insertFunction(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="palette-item">
  <p>{insertFunction(state)}</p>
</div>

<style>
  .palette-item {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
