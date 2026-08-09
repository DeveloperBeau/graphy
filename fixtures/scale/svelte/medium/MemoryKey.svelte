<script>
  export let state = [];

  function recallRegister(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="memory-key">
  <p>{recallRegister(state)}</p>
</div>

<style>
  .memory-key {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
