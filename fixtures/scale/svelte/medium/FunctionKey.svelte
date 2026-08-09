<script>
  export let state = [];

  function emitFunction(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="function-key">
  <p>{emitFunction(state)}</p>
</div>

<style>
  .function-key {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
